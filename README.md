# Akrievo Alert — Alert system for VORP

This repository contains `skrievo_alert`, a small server-side alert system for VORP-based servers. It allows sending notifications and temporary blips to players or job groups.

---

Deutsch
-------

Kurzbeschreibung
----------------
`skrievo_alert` ermöglicht es Spielern, serverseitig Alarme an bestimmte Jobs oder einzelne Spieler zu senden. Betroffene Spieler erhalten eine Ingame-Notification (Tip) und einen temporären Blip auf der Karte. Das Script ist bewusst minimal gehalten und leicht in Vorp-Server integrierbar.

Hauptfunktionen
---------------
- Alarme an einzelne Spieler oder an ganze Jobs senden
- Temporäre Blips für Benachrichtigte erzeugen
- Serverseitige Guards gegen fehlende Vorp-Exports (kompatibel mit Vorp Core 3.3)
- Fallback auf das legacy `getCore`-Event, wenn nötig

Voraussetzungen
---------------
- Vorp Core 3.3 (empfohlen)
- Optional: `vorp_inventory`, falls Inventar-Funktionen verwendet werden
- FiveM / RedM Server-Umgebung

Installation
------------
1. Ordner `skrievo_alert` in dein `resources`-Verzeichnis kopieren.
2. In deiner `server.cfg` oder `resources.cfg` hinzufügen:

   ensure skrievo_alert

Konfiguration
-------------
- Passe Job-Namen, Blip-Parameter und Textmeldungen direkt in den Skripten an (z. B. in einer `config.lua`, falls vorhanden).
- Die wichtigsten Einstellungen befinden sich serverseitig in `server.lua`.

Beispiel: Alarm auslösen (Server-Event)
-------------------------------------
Ein Beispielaufruf (serverseitig oder clientseitig per TriggerServerEvent):

```lua
TriggerServerEvent("skrievo_alert:sendalert", players, job, alert, blip, doctor)
```

Parameter (kurz):
- players: Liste der Spieler oder `GetPlayers()`-Rückgabe
- job: String oder Array von Job-Namen, die benachrichtigt werden sollen
- alert: Textnachricht
- blip: Blip-Informationen (je nach Implementation)
- doctor: optionaler Parameter für spezielle Markierungen

Kompatibilität & Hinweise
-------------------------
- Dieses Skript wurde am 2025-11-19 für Vorp Core 3.3 angepasst. Die Server-Initialisierung versucht zuerst `exports.vorp_core:vorpAPI()` und fällt bei Bedarf auf das legacy `getCore`-Event zurück.
- Änderungen wurden bewusst konservativ vorgenommen, um Abwärtskompatibilität zu wahren.

Changelog
---------
- 2025-11-19 — Update: Anpassungen für Vorp Core 3.3, defensive Exports-Initialisierung, `safeGetUser`-Wrapper, Prüfungen für Player-IDs (Guard beim Aufruf von `TriggerClientEvent`).

---

English
-------

Short description
-----------------
`skrievo_alert` allows players to send server-side alerts to specific jobs or individual players. Notified players will receive an in-game tip and a temporary map blip. The script is intentionally minimal and easy to integrate into VORP servers.

Main features
-------------
- Send alerts to individual players or job groups
- Create temporary blips for notified players
- Server-side guards for missing VORP exports (compatible with VORP Core 3.3)
- Fallback to legacy `getCore` event if needed

Requirements
------------
- VORP Core 3.3 (recommended)
- Optional: `vorp_inventory` if inventory-related features are used
- FiveM / RedM server environment

Installation
------------
1. Copy the `skrievo_alert` folder into your server's `resources` directory.
2. Add to your `server.cfg` or resources config:

   ensure skrievo_alert

Configuration
-------------
- Adjust job names, blip parameters and messages in the scripts (e.g. `config.lua` if available).
- The main server configuration is in `server.lua`.

Example: triggering an alert (server event)
------------------------------------------
Example call (server-side or client-side via TriggerServerEvent):

```lua
TriggerServerEvent("skrievo_alert:sendalert", players, job, alert, blip, doctor)
```

Parameters (brief):
- players: list of players or the `GetPlayers()` result
- job: string or array of job names to notify
- alert: text message
- blip: blip information (depending on implementation)
- doctor: optional parameter for special marking

Compatibility & notes
---------------------
- Updated on 2025-11-19 for VORP Core 3.3. Server initialization tries `exports.vorp_core:vorpAPI()` first and falls back to `getCore` if necessary.
- Changes are conservative to keep backward compatibility.

Changelog
---------
- 2025-11-19 — Update: adjustments for VORP Core 3.3, defensive exports initialization, `safeGetUser` wrapper, guards for player IDs before `TriggerClientEvent`.

License & Support
-----------------
- License: see project-wide license file (if present).
- Support: If you need help, open an issue or check the VORP documentation / community.

Note
----

This README is meant as a short guide. I can add a `config.lua` template or badges/examples if you want.
