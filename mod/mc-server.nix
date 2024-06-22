{ config, pkgs, lib, ... }:

let
	cfg = config.flame.mc-server;
in {
	options.flame.mc-server = {
		ram = lib.mkOption {
			default = "14G";
			type = lib.types.str;
			description = "RAM to allocate to Java";
		};
	};

	config = {
		services.logind.lidSwitch = "ignore";
		services.minecraft-server = {
			enable = true;
			eula = true;
			package = pkgs.papermc; 
			jvmOpts = "-Xmx${cfg.ram} -Xms${cfg.ram} -XX:+AlwaysPreTouch -XX:+DisableExplicitGC -XX:+ParallelRefProcEnabled -XX:+PerfDisableSharedMem -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:G1HeapRegionSize=8M -XX:G1HeapWastePercent=5 -XX:G1MaxNewSizePercent=40 -XX:G1MixedGCCountTarget=4 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1NewSizePercent=30 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:G1ReservePercent=20 -XX:InitiatingHeapOccupancyPercent=15 -XX:MaxGCPauseMillis=200 -XX:MaxTenuringThreshold=1 -XX:SurvivorRatio=32";
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
				view-distance = 128;
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
				Psycho_Blade1 = "2a4d0a8f-d55c-4c83-9db5-a06665ad1231";
				StupidSufy = "b7248d94-9b5a-45b4-83b4-1f0d1f0d850b";
				ippon_datara = "96b3cf60-32f5-4cb5-9a38-43178c59aea3";
				vio_q = "861b6592-a1aa-4b63-bb9d-aac16637f30a";
				Attticusss = "af017840-c5a7-4615-af67-edc8f52c4deb";
				blood_ANDtendons = "0a66ec37-9a7b-4fe9-98e8-0107cd815cc4";
				NumberVoice7226 = "acd79e6b-ec94-478d-ad4b-d43d7b8f3ec6";
				Sephiatone = "7095eae3-c96c-42e3-9977-e1af8c3d51ff";
			};
		};
	};
}
