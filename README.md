# Expected Goals to Expected Points (xPts)

## Motivation
Ziel dieses Projekts ist es, Expected Goals (xG) in Expected Points (xPts)
zu überführen, um Spielleistungen im Fußball probabilistisch zu bewerten.

## Daten
- Bundesliga-Spieldaten mit xG-Werten pro Team und Spiel
- Quelle: FBref (Daten basieren auf StatsBomb)
- Verwendeter Datensatz: `bundesliga_matches_1_to_15.csv`

## Methodik

- Bereinigung und Vorbereitung der Bundesliga-Spieldaten:
  - unnötige Spalten und Zeilen entfernt
  - xG-Werte in numerisches Format konvertiert

- Berechnung der Expected Points (xPts) pro Team und Spiel:
  - Für Heim- und Auswärtsteam separat
  - Erwartete Tore (xG) als Poisson-Verteilung modelliert
  - Wahrscheinlichkeit aller möglichen (bis maximal 6 Tore pro Team) Spielergebnisse simuliert
  - Erwartete Punkte berechnet: Sieg = 3, Remis = 1, Niederlage = 0

- Aggregation auf Team-Ebene:
  - xPts für alle Spiele eines Teams summiert
  - Tabelle der Teams nach erwarteten Punkten erstellt

## Umsetzung
- Programmiersprache: R
- Zentrale Logik im Skript `xg_to_xpts.R`

## Hinweise
Das Projekt entstand als eigenständige Initiative, um analytische Modelle im Fußballkontext
praktisch umzusetzen und Erfahrungen in Data Science zu sammeln.
