import defaultParserInterface from './utils/defaultParserInterface';

const ID = 'ocaml';
const locKeys = [
  'loc',
  'pcd_loc',
  'pcf_loc',
  'pci_loc',
  'pcl_loc',
  'pctf_loc',
  'pcty_loc',
  'pexp_loc',
  'pexp_loc_stack',
  'pincl_loc',
  'pld_loc',
  'pmb_loc',
  'pmd_loc',
  'pms_loc',
  'pmod_loc',
  'pmtd_loc',
  'pmty_loc',
  'popen_loc',
  'ppat_loc',
  'ppat_loc_stack',
  'psig_loc',
  'pstr_loc',
  'ptyp_loc',
  'ptyp_loc_stack',
  'ptype_loc',
  'pval_loc',
  'pvb_loc',
  'pbop_loc',
  'ptyext_loc',
  'pext_loc',
  'ptyexn_loc',
  'pdir_loc',
  'pdira_loc',
];

export default {
  ...defaultParserInterface,

  id: ID,
  displayName: ID,
  version: "0.1",
  homepage: `https://google.com`,
  locationProps: new Set(locKeys),

  loadParser(callback) {
    //require(['astexplorer-refmt'], callback);
  },

  parse(parser, code) {
    return parser.parseOcaml(code);
  },

  getNodeName(node) {
    return node.type;
  },

  nodeToRange(node) {
    const locKey = locKeys.find(key => Object.prototype.hasOwnProperty.call(node, key));
    if (locKey) {
      const range = (node[locKey].origin_loc_start != undefined) ? [
        node[locKey].loc_start.pos_cnum,
        node[locKey].loc_end.pos_cnum,
        node[locKey].origin_loc_start.pos_cnum,
        node[locKey].origin_loc_end.pos_cnum,
      ]
        : [
          node[locKey].loc_start.pos_cnum,
          node[locKey].loc_end.pos_cnum,
        ]
      return range;
    }
  },
};
