{ config, pkgs, inputs, ... }: {
	services.minecraft-server = {
		enable = true;
		eula = true;
		package = pkgs.papermc;
		jvmOpts = "-Xmx6G -Xms6G";
		openFirewall = true;
		declarative = true;
		serverProperties = {
			enable-jmx-monitoring = false;
			# rcon.port = 25575;
			# level-seed = ;
			gamemode = "survival";
			enable-command-block = false;
			enable-query = false;
			# generator-settings = {};
			enforce-secure-profile = true;
			level-name = "world";
			motd = "the place to be on a saturday";
			# query.port = 25565;
			pvp = true;
			generate-structures = true;
			max-chained-neighbor-updates = 1000000;
			difficulty = "hard";
			network-compression-threshold = 256;
			max-tick-time = 60000;
			require-resource-pack = false;
			use-native-transport = true;
			max-players = 20;
			online-mode = true;
			enable-status = true;
			allow-flight = false;
			# initial-disabled-packs = ;
			broadcast-rcon-to-ops = true;
			view-distance = 10;
			# server-ip = ;
			# resource-pack-prompt = ;
			allow-nether = true;
			server-port = 25565;
			enable-rcon = false;
			sync-chunk-writes = true;
			op-permission-level = 4;
			prevent-proxy-connections = false;
			hide-online-players = false;
			# resource-pack = ;
			entity-broadcast-range-percentage = 100;
			simulation-distance = 10;
			# rcon.password = ;
			player-idle-timeout = 0;
			force-gamemode = false;
			rate-limit = 0;
			hardcore = false;
			white-list = true;
			broadcast-console-to-ops = true;
			spawn-npcs = true;
			spawn-animals = true;
			log-ips = true;
			function-permission-level = 2;
			initial-enabled-packs = "vanilla";
			level-type = "minecraft:normal";
			# text-filtering-config = ;
			spawn-monsters = true;
			enforce-whitelist = true;
			spawn-protection = 0;
			# resource-pack-sha1 = ;
			max-world-size = 5000;
		};
		whitelist = {
			Flameopathic = "040ebdc7-9ca1-475d-9b3d-4fb62a29b19e";
			DerpLemonade = "b32f9046-264b-4e02-911c-90fbcbd167a7";
			nox_quack = "19051a2b-ac8e-4bab-86fd-e9ab42e8de3d";
			Mercadies = "c8200af1-7fb8-48fc-83b8-1066ef221333";
			LadyIanite07 = "aefc488b-ff80-4b4f-8b73-f8241e5df6d5";
		};
	};
}
