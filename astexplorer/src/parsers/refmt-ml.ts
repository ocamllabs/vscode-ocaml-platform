import type { AstObject, AstValue, Range } from "../ast";
import type { Parser } from "../parserMiddleware";

const locKeys = [
  "loc",
  "pcd_loc",
  "pcf_loc",
  "pci_loc",
  "pcl_loc",
  "pctf_loc",
  "pcty_loc",
  "pexp_loc",
  "pexp_loc_stack",
  "pincl_loc",
  "pld_loc",
  "pmb_loc",
  "pmd_loc",
  "pms_loc",
  "pmod_loc",
  "pmtd_loc",
  "pmty_loc",
  "popen_loc",
  "ppat_loc",
  "ppat_loc_stack",
  "psig_loc",
  "pstr_loc",
  "ptyp_loc",
  "ptyp_loc_stack",
  "ptype_loc",
  "pval_loc",
  "pvb_loc",
  "pbop_loc",
  "ptyext_loc",
  "pext_loc",
  "ptyexn_loc",
  "pdir_loc",
  "pdira_loc",
] as const;

function posCnum(value: AstValue): number {
  return (value as AstObject)["pos_cnum"] as number;
}

const parser: Parser = {
  locationProps: new Set(locKeys),
  typeProps: new Set(["type"]),

  getNodeName(node) {
    return (node as AstObject)["type"] as string | undefined;
  },

  nodeToRange(node) {
    const obj = node as AstObject;
    const locKey = locKeys.find((key) => Object.prototype.hasOwnProperty.call(obj, key));
    if (!locKey) {
      return undefined;
    }
    const loc = obj[locKey] as AstObject;
    if (loc["origin_loc_start"] != undefined) {
      return [
        posCnum(loc["loc_start"]),
        posCnum(loc["loc_end"]),
        posCnum(loc["origin_loc_start"]),
        posCnum(loc["origin_loc_end"]),
      ] as Range;
    }
    return [posCnum(loc["loc_start"]), posCnum(loc["loc_end"])] as Range;
  },

  *forEachProperty(node) {
    if (node && typeof node === "object") {
      const obj = node as Record<string, AstValue>;
      for (const key in obj) {
        yield { value: obj[key], key };
      }
    }
  },
};

export default parser;
