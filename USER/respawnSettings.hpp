//WAVE RESPAWN =================================================================
waveRespawnEnabled = 1;                                                         //Wave Respawn ein-/ausschalten (1/0)

bluforWaveSize = 2;                                                            //Wellengröße Blufor (-1 == automatisch)
opforWaveSize = 2;                                                             //Wellengröße Opfor (-1 == automatisch)
indepWaveSize = 2;                                                             //Wellengröße Independent (-1 == automatisch)
civWaveSize = 2;

bluforWaveLifes = 9999;                                                         //Wie oft ein Blufor Spieler respawnen kann
opforWaveLifes = 9999;                                                          //Wie oft ein Opfor Spieler respawnen kann
indepWaveLifes = 9999;                                                          //Wie oft ein Independent Spieler respawnen kann
civWaveLifes = 9999;

bluforInterruptCondition = "missionNameSpace getVariable ['tembelanTrap_lastFight', false]";                                             //Bedingung nach der der Blufor Waverespawn deaktiviert wird
opforInterruptCondition = "missionNameSpace getVariable ['tembelanTrap_lastFight', false]";                                              //Bedingung nach der der Opfor Waverespawn deaktiviert wird
indepInterruptCondition = "missionNameSpace getVariable ['tembelanTrap_lastFight', false]";                                              //Bedingung nach der der Independent Waverespawn deaktiviert wird
civInterruptCondition = "missionNameSpace getVariable ['tembelanTrap_lastFight', false]";                                              //Bedingung nach der der Civilian Waverespawn deaktiviert wird

waverespawntimePlayer = 3;                                                     //Spielerrespawnzeit, bevor er der Welle hinzugefügt wird

// todo remove debug
waverespawntimeBlu = 120;                                                        //Wellenrespawnzeit Blufor in Sekunden
waverespawntimeOpf = 120;                                                        //Wellenrespawnzeit Opfor in Sekunden
waverespawntimeInd = 120;                                                        //Wellenrespawnzeit Independent in Sekunden
waverespawntimeCiv = 120;                                                        //Wellenrespawnzeit Civilian in Sekunden


//NORMALER RESPAWN =============================================================//Diese Einträge sind nur bei ausgeschaltetem Wave Respawn wichtig
respawntimeBlu = 9999;                                                          //Respawnzeit Blufor in Sekunden
respawntimeOpf = 9999;                                                          //Respawnzeit Opfor in Sekunden
respawntimeInd = 9999;                                                          //Respawnzeit Independent in Sekunden
respawntimeCiv = 9999;                                                          //Respawnzeit Civilian in Sekunden