[@bs.module "semver"]
external satisfies: (string, string) => bool = "satisfies";

[@bs.module "semver"] external minVersion: string => string = "minVersion";
