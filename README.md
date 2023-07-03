# Wstęp
Oficjalny gamemode serwera Just Play na platformie MTA: San Andreas

# Autorzy podstawy paczki
- Xantris (programista bazowej paczki InsideMTA)
- Wilku (Modeler)
- KingMoses (Web Developer)
i inni..

# Autorzy projektu Just Play
- NyAngel
- DeMoNeK_

# Podziękowania dla
- kkuba (Zasób wykrywający boty na rybaka)
- mAti. (Poprawki map)
- Bocha_ (Poprawiony model felg)

# Jak wgrać i uruchomić gamemode?

1. Pobierz paczkę, następnie umieść ją w głównym folderze resources MTA.
2. Usuń lub przenieś zasób TR_dashboard (nowy znajduje się w [2.0 JP])
3. Przejdz do strony phpMyAdmin na stronie twojej bazy danych następnie wybierz istniejącą baze lub stówrz nową.
4. Zaimportuj plik .sql znajdujący się w repozytorium (baza_danych.sql).
5. Przejdź do głównego katalogu gamemode, otwóz zasób TR_mysql -> s.lua i uzupełnij dane do połączenia z bazą.
6. Dodaj zasoby TR_starter, TR_core, TR_admin, TR_models do ACL.
7. Włącz zasób TR_mysql a następnie TR_starter i poczekaj aż wszystko się uruchomi.

# Na co nie wydajemy pozwolenia jako autorzy?
- Na korzystanie z grafiki loga serwera.
