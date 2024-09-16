.PHONY: update clean
update:
	home-manager switch --flake .#functionalhacker

clean:
	nix-collect-garbage -d
