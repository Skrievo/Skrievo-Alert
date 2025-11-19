--[[
  skrievo_alert configuration

  Kurze Hinweise (DE/EN):
  - Passe die Einträge in `Config.alerts` an, um verschiedene Alarmtypen / Befehle zu definieren.
  - `jobs` ist eine Liste von Job-Identifiers, die die Alarmnachricht erhalten sollen.
  - `blip` enthält Blip-Parameter (Icon/Sprite und Anzeigename). Die Keys wurden bewusst
    an bestehende Implementationen angepasst (blipsprite / Name).

  Small notes (EN):
  - Adjust entries in `Config.alerts` to define alert types and their chat/command triggers.
  - `jobs` is an array of job names that will be notified when the alert triggers.
  - `blip` holds blip-related settings (sprite id and display name).
]]

Config = {}

-- Definitions for alert types. Key = alert identifier used in code (e.g. 'police').
-- Fields: 
--  command: command name to trigger the alert (if you expose commands)
--  jobs: table/list of job identifiers that should receive the alert
--  msg: the message text sent as alert to the target players
--  isdoctor: boolean flag used by some flows to mark a medic/doctor-type alert
--  blip: table with blip details (blipsprite = integer, Name = string)
Config.alerts = {
    police = {
        command = "alertpolice",
        jobs = { "police", "marshal" },           -- jobs that receive the alert
        msg = "Police assistance needed. Check the map for coordinates.",
        isdoctor = false,
        blip = {
            blipsprite = 2119977580,               -- sprite/hash for the blip (engine-specific)
            Name = "Police Alert",
        },
    },

    medic = {
        command = "alertmedic",
        jobs = { "medic" },
        msg = "Medic assistance needed. Check the map for coordinates.",
        isdoctor = true,
        blip = {
            blipsprite = 2119977580,
            Name = "Medic Alert",
        },
    },

    doctor = {
        command = "alertdoctor",
        jobs = { "doctor" },
        msg = "Doctor assistance needed. Check the map for coordinates.",
        isdoctor = true,
        blip = {
            blipsprite = 2119977580,
            Name = "Doctor Alert",
        },
    },
}

-- Command/flow settings
Config.medicresponse = "resp"             -- event/command name for medic response (can be used by clients)
Config.cancelblipcommand = "calert"       -- command to cancel/remove alert blips

-- Timing
Config.alertcooldown = 900                 -- cooldown between same alerts in seconds (default: 15 minutes)
Config.defaultBlipDuration = 180           -- how long (seconds) a created blip remains (default: 3 minutes)

-- Optional: add any custom settings below, e.g. icon color, sound, permission checks, etc.

return Config

