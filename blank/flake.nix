{
	description = "Blank template";

	inputs.nixpkgs.url = "nixpkgs/nixos-unstable";

	outputs = { self, nixpkgs }: let 
		supportedSystems = [ "x86_64-linux" "x86_64-darwin" ];

		forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

		nixpkgsFor = forAllSystems(system: import nixpkgs {
			inherit system;
			overlays = [ self.overlay ];
		});
	in
	{
		overlay = final: prev: {};

		packages = forAllSystems(system: {});

		devShells = forAllSystems(system: let pkgs = nixpkgsFor.${system};
			in {
				default = pkgs.mkShell {
					packages = [];
					buildInputs = with pkgs; [ ];

					shellHook = "export PS1='[$PWD]$ '";
				};
			}
		);
	};
}
