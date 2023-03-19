{
  description = "Packages for Locust";

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      formatter = forAllSystems (
        system:
        nixpkgs.legacyPackages.${system}.nixpkgs-fmt
      );

      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          roundrobin = pkgs.callPackage ./packages/roundrobin { };
        in
        {
          roundrobin = roundrobin;
          locust = pkgs.callPackage ./packages/locust {
            inherit roundrobin;
          };
        }
      );
    };
}