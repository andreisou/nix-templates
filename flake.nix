{
	description = "Nix templates";

	outputs = self: {
		templates = {
			c = {
				description = "C template";
				path = ./c;
			};
			python = {
				description = "Python template";
				path = ./python;
			};
		};
	};
}
