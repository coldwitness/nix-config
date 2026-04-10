{
  inputs,
  ...
}:
let
  inherit (inputs.nixpkgs) lib;
  mergeOptSets = left: right:
    if builtins.isAttrs left && builtins.isAttrs right then
      let
        mergeVal = name: lval: rval:
          if builtins.isAttrs lval && builtins.isAttrs rval then
            mergeOptSets lval rval
          else if builtins.isList lval && builtins.isList rval then
            lval ++ rval
          else
            rval;
      in
      lib.foldl' (acc: name:
        if builtins.hasAttr name right then
          acc // { ${name} =
            if builtins.hasAttr name left
            then mergeVal name left.${name} right.${name}
            else right.${name};
          }
        else
          acc
      ) left (builtins.attrNames right)
    else if builtins.isList left && builtins.isList right then
      left ++ right
    else
      right;
  mergeOptSetsList = initial: optsList:
    lib.foldl' (acc: opts: mergeOptSets acc opts) initial optsList;
in
mergeOptSetsList
