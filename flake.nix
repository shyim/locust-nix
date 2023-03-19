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
          psycogreen = pkgs.callPackage ./packages/psycogreen { };
        in
        {
          roundrobin = roundrobin;
          psycogreen = psycogreen;
          locust = pkgs.callPackage ./packages/locust {
            inherit roundrobin;
          };
          extensions = {
            locust-timescale = pkgs.callPackage ./packages/locust-timescale {
              inherit psycogreen;
            };
          };
          locust-timescale = self.packages.${system}.locust.overrideAttrs (
            oldAttrs:
            {
              propagatedBuildInputs = oldAttrs.propagatedBuildInputs ++ [ self.packages.${system}.extensions.locust-timescale ];
            }
          );
        }
      );
    };
}