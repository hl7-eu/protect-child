#!/usr/bin/env python3
"""Build a worked-example journey figure (SVG) from a bundle's FSH definition.

Usage:  python3 input/images-source/build-journey-svg.py <bundle.fsh> <out.svg> "<title>"

The figure is generated from the Bundle entry list, grouped by the "// ---- ... ----"
section comments in the bundle file, so it cannot drift from the Bundle it depicts.
Each chip links to that example's artifact page.
"""
import re, sys, glob, json, os, html

REPO = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
W, MARGIN, CHIP_W, CHIP_H, GAP = 920, 20, 210, 64, 10
PER_ROW = 4
PALETTE = {                      # resource type -> (fill, stroke, text)
    'Patient':      ('#eef2ff', '#c7d2fe', '#3730a3'),
    'Organization': ('#f5f5f4', '#d6d3d1', '#44403c'),
    'Encounter':    ('#fef3c7', '#fcd34d', '#92400e'),
    'Procedure':    ('#e0f2fe', '#7dd3fc', '#075985'),
    'Condition':    ('#fee2e2', '#fca5a5', '#991b1b'),
    'Observation':  ('#dcfce7', '#86efac', '#166534'),
    'MedicationStatement': ('#f3e8ff', '#d8b4fe', '#6b21a8'),
    'Medication':   ('#faf5ff', '#e9d5ff', '#7e22ce'),
    'Specimen':     ('#ccfbf1', '#5eead4', '#115e59'),
    'ServiceRequest': ('#ecfeff', '#a5f3fc', '#155e75'),
    'ObservationDefinition': ('#f8fafc', '#cbd5e1', '#334155'),
}
DEFAULT = ('#f8fafc', '#cbd5e1', '#334155')

# Parent values that are not bare R4 resource names.
EXTERNAL_PARENTS = {
    'medication-eu-core':   'Medication',
    'organization-eu-core': 'Organization',
}
R4_TYPES = {'Patient','Encounter','Procedure','Condition','Observation','MedicationStatement',
            'Medication','Specimen','ServiceRequest','ObservationDefinition','Organization','Bundle'}

def profile_index():
    """profile name -> (id, resource type).

    Prefers the generated StructureDefinitions in output/, but falls back to
    parsing the FSH directly so the figures can be rebuilt without a completed
    IG build (the FHIR package registry is not always reachable).
    """
    name2, id2type = {}, {}
    for p in glob.glob(os.path.join(REPO, 'output', 'StructureDefinition-*.json')):
        try: j = json.load(open(p))
        except Exception: continue
        if j.get('kind') == 'logical': continue
        id2type[j['id']] = j.get('type')
        name2[j.get('name')] = j['id']
    if name2:
        return name2, id2type

    # --- fallback: read Profile blocks out of the FSH ---
    parents = {}
    for f in sorted(glob.glob(os.path.join(REPO, 'input', 'fsh', '*.fsh'))):
        txt = open(f, encoding='utf-8').read()
        for block in re.split(r'(?m)^(?=Profile:)', txt):
            m = re.match(r'Profile:\s*(\S+)', block)
            if not m: continue
            name = m.group(1)
            pid = re.search(r'^Id:\s*(\S+)', block, re.M)
            par = re.search(r'^Parent:\s*(\S+)', block, re.M)
            name2[name] = pid.group(1) if pid else name
            parents[name] = par.group(1) if par else ''

    def resolve(name, seen=()):
        par = parents.get(name, '')
        if par in R4_TYPES: return par
        if par.startswith('http'):
            return EXTERNAL_PARENTS.get(par.rsplit('/', 1)[-1], '')
        if par and par not in seen:
            return resolve(par, seen + (name,))
        return ''

    for name in parents:
        id2type[name2[name]] = resolve(name)
    return name2, id2type

def instances():
    """instance name -> dict(profile, id, identifier, ref)"""
    out, cur = {}, None
    for f in sorted(glob.glob(os.path.join(REPO, 'input', 'fsh', '*.fsh'))):
        for line in open(f, encoding='utf-8'):
            if re.match(r'^(Profile|CodeSystem|ValueSet|Extension|Logical|Alias|RuleSet|Invariant|Mapping):', line):
                cur = None
            m = re.match(r'^Instance:\s*(\S+)', line)
            if m:
                cur = m.group(1); out[cur] = {'profile': None, 'id': cur, 'identifier': None, 'ref': None}
                continue
            if not cur: continue
            m = re.match(r'^InstanceOf:\s*(\S+)', line)
            if m: out[cur]['profile'] = m.group(1)
            m = re.match(r'^\* id = "([^"]+)"', line)
            if m: out[cur]['id'] = m.group(1)
            m = re.match(r'^\* identifier(?:\[0\])?\.value = "([^"]+)"', line)
            if m and not out[cur]['identifier']: out[cur]['identifier'] = m.group(1)
            m = re.match(r'^\* (encounter|context|partOf|focus|reasonReference) = Reference\((\w+)\)', line.strip())
            if m and not out[cur]['ref']: out[cur]['ref'] = (m.group(1), m.group(2))
    return out

def sections(bundle_fsh):
    """[(section title, [instance names])] in bundle order."""
    secs, title, items, started = [], None, [], False
    for line in open(bundle_fsh, encoding='utf-8'):
        if not started:
            # section comments only count once the Bundle's own body has begun
            started = line.startswith('* type = #collection')
            continue
        m = re.match(r'^//\s*----\s*(.+?)\s*----', line)
        if m:
            if title: secs.append((title, items))
            title, items = m.group(1), []
            continue
        m = re.match(r'^\* entry\[=\]\.resource = (\S+)', line)
        if m and title is not None: items.append(m.group(1))
    if title: secs.append((title, items))
    return secs

def esc(s): return html.escape(str(s), quote=True)

def clip(s, n):
    s = str(s)
    return s if len(s) <= n else s[:n-1] + '…'

def build(bundle_fsh, out_svg, title):
    render(sections(bundle_fsh), out_svg, title)

def build_split(bundle_fsh, out_prefix, title):
    """One SVG per Bundle section, named <prefix>-NN-<slug>.svg."""
    for i, sec in enumerate(sections(bundle_fsh), 1):
        slug = re.sub(r'[^a-z0-9]+', '-', re.split(r'[\u2014(]', sec[0])[0].lower()).strip('-')
        slug = '-'.join(slug.split('-')[:3])
        render([sec], f"{out_prefix}-{i:02d}-{slug}.svg", sec[0], header=False)

def render(secs, out_svg, title, header=True):
    name2id, id2type = profile_index()
    inst = instances()
    # geometry
    y, rows = (64 if header else 16), []
    for stitle, items in secs:
        y += 34 if header else 0
        for i in range(0, len(items), PER_ROW):
            rows.append((stitle if i == 0 else None, y, items[i:i+PER_ROW]))
            y += CHIP_H + GAP
        y += 10
    height = y + 16
    o = []
    o.append(f'<svg viewBox="0 0 {W} {height}" xmlns="http://www.w3.org/2000/svg" role="img" '
             f'font-family="system-ui, -apple-system, Segoe UI, sans-serif" font-size="12">')
    o.append(f'<title>{esc(title)}</title>')
    o.append('<desc>Resources in the worked-example Bundle, grouped by the visit or phase they belong to, '
             'coloured by FHIR resource type. Each chip names the resource, its business identifier and its '
             'profile, and records the reference it makes to another entry.</desc>')
    o.append('<style>a:hover rect{opacity:.82}a rect,a text{cursor:pointer}</style>')
    o.append(f'<rect x="0" y="0" width="{W}" height="{height}" fill="white"/>')
    if header:
        o.append(f'<text x="{MARGIN}" y="30" font-size="15" font-weight="700" fill="#111">{esc(title)}</text>')
        o.append(f'<text x="{MARGIN}" y="48" font-size="11" fill="#666">Grouped by visit; colour by FHIR resource type. '
                 f'Grey text on each chip is the reference that resource makes.</text>')
    cur_sec = None
    for stitle, ry, items in rows:
        if stitle and header:
            o.append(f'<rect x="{MARGIN}" y="{ry-26}" width="{W-2*MARGIN}" height="22" rx="3" fill="#f1f5f9" stroke="#e2e8f0"/>')
            o.append(f'<text x="{MARGIN+9}" y="{ry-11}" font-size="11.5" font-weight="600" fill="#334155">{esc(stitle)}</text>')
        for k, name in enumerate(items):
            d = inst.get(name, {})
            prof = d.get('profile'); pid = name2id.get(prof, prof or '')
            rtype = id2type.get(pid, '')
            fill, stroke, ink = PALETTE.get(rtype, DEFAULT)
            x = MARGIN + k*(CHIP_W+GAP)
            href = f"{rtype}-{d.get('id', name)}.html" if rtype else '#'
            o.append(f'<a href="{esc(href)}">')
            o.append(f'<rect x="{x}" y="{ry}" width="{CHIP_W}" height="{CHIP_H}" rx="4" fill="{fill}" stroke="{stroke}"/>')
            o.append(f'<text x="{x+9}" y="{ry+17}" font-size="12" font-weight="700" fill="{ink}">{esc(clip(rtype or name,26))}</text>')
            o.append(f'<text x="{x+9}" y="{ry+32}" font-size="11" fill="#111">{esc(clip(d.get("identifier") or d.get("id") or name,30))}</text>')
            o.append(f'<text x="{x+9}" y="{ry+45}" font-size="10" fill="#64748b">{esc(clip(pid,32))}</text>')
            ref = d.get('ref')
            if ref:
                tgt = inst.get(ref[1], {}).get('identifier') or ref[1]
                o.append(f'<text x="{x+9}" y="{ry+57}" font-size="9.5" fill="#94a3b8">{esc(clip(ref[0]+" → "+str(tgt),34))}</text>')
            o.append('</a>')
    o.append('</svg>')
    open(out_svg, 'w', encoding='utf-8').write('\n'.join(o) + '\n')
    n = sum(len(i) for _, i in secs)
    print(f"{out_svg}: {n} resources, {len(secs)} groups, {W}x{height}")

if __name__ == '__main__':
    if '--split' in sys.argv:
        build_split(sys.argv[1], sys.argv[2], sys.argv[3])
    else:
        build(sys.argv[1], sys.argv[2], sys.argv[3])
