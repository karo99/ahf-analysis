
library(shiny)
library(shinydashboard)
library(data.table)
library(dplyr)
library(survival)
library(survminer)
library(janitor)
library(tidyr)
library(readr)
library(hrbrthemes)
library(viridis)
library(dashboardthemes)
library(shinyWidgets)
library(extrafont)

#add fonts
require(showtext)
font_add_google(name = "Roboto Condensed", family = "Roboto Condensed",
                regular.wt = 400, bold.wt = 700)
showtext_auto()
showtext_opts(dpi = 112)


#read data from file
myData <- read_csv2("./bazaAHF.csv")
attach(myData)

# clean variables' names
myData = clean_names(myData)

# add new column 'status'
myData$status = 0
myData$status[myData$zgon_1_zyje_0_brak_uprawnien_2_brak_kontaktu_3_wycofana_zgoda_4 == "żyje"] <- 0
myData$status[myData$zgon_1_zyje_0_brak_uprawnien_2_brak_kontaktu_3_wycofana_zgoda_4 == "zgon"] <- 1

# remove unnecessary columns
myData <- select(myData, -c(nr_telefonu, drugi_nr_telefonu,odpowiedzialny_za_crf_biegus_1_siwolowski_2_gajewski_3_nawrocka_4_mlynarska_5_krzysztofik_6_sokolski_7))


# subset for analysis
survival <- myData %>% select(plec_0_kobieta_1_mezczyzna,
                  niedokrwienna_1_nadcisnienie_tetnicze_2_wada_zastawkowa_3_toksyczna_alkohol_4_pozapalna_5_arytmia_6_nieznana_7_inna_8,
                  dekompensacja_de_novo_0_w_pns_1,
                  choroba_niedokrwienna_tak_1_nie_0, ozw_tak_1_nie_0, dekompensacja_tak_1_nie_0,
                  profil_hemodynamiczny_ns_z_zachowana_frakcja_wyrzutowa_0_ns_skurczowa_1, ckd_tak_1_nie_0,
                  nadcisnienie_tetnicze_tak_1_nie_0, wady_zastawkowe_tak_1_nie_0, zaburzenia_rytmu_serca_tak_1_nie_0,
                  choroby_watroby_tak_1_nie_0, nikotynizm_tak_1_nie_0, alkohol_nie_0_tak_1_okazjonalnie_3,
                  cukrzyca_tak_1_nie_0, spadek_tolerancji_wysilku_a_nie_0_tak_1, dusznosc_spoczynkowa_a_nie_0_tak_1, zaburzenia_lipidowe_tak_1_nie_0,
                  niedoczynnosc_tarczycy_1_brak_niedoczynnosci_0, powiekszenie_watroby_a_nie_0_tak_1,
                  zastoinowa_ns_tak_1_nie_0, udar_tia_tak_1_nie_0, mr_brak_0_lagodna_1_umiarkowana_2_ciezka_3 ,pochp_astma_tak_1_nie_0, hr_a_miarowa_1_niemiarowa_0, stan_kliniczny_b_poprawa_1_pogorszenie_2_bez_zmian_3, 
                  pogorszenie_chf_w_trakcie_leczenia_nie_0_tak_1, ablacja_nie_0_tak_1,klasa_nyha_i_1_ii_2_iii_3_iv_4,
                  klasa_nyha_a_i_1_ii_2_iii_3_iv_4,
                  klasa_nyha_b_i_1_ii_2_iii_3_iv_4, klasa_nyha_c_i_1_ii_2_iii_3_iv_4, klasa_nyha_d_i_1_ii_2_iii_3_iv_4,
                  status, czas_fu, wiek, zastoinowa_ns_od_ilu_lat, nadcisnienie_tetnicze_od_ilu_lat,
                  dekompensacja_ile_razy,
                  nie_pali_od_lat, palil_pali_przez_lat, cukrzyca_od_ilu_lat, dusznosc_a_od_ilu_dni,
                  waga_ciala_a, hgb_a_przyjecie, hct_a, rbc_a, wbc_a, mono_a_percent, lymph_a_percent,
                  neutr_a_percent, na_sod_a, mocznik_a, glukoza_a, crp_a, albuminy_a, troponina_i_a
                  )
survival <- setNames(survival, c('plec',
                                 'Etiologia',
                                 'dekompensacja_de_novo_w_pns',
                                 'choroba_niedokrwienna', 'ostre_zapalenie_wiencowe', 'dekompensacja',
                                 'profil_hemodynamiczny', 'przewlekla_niewydolnosc_nerek',
                                 'nadcisnienie_tetnicze', 'wady_zastawkowe', 'zaburzenia_rytmu_serca',
                                 'choroby_watroby', 'nikotynizm', 'alkohol',
                                 'cukrzyca','spadek_tolerancji_wysilku', 'dusznosc_spoczynkowa_a', 'zaburzenia_lipidowe',
                                 'niedoczynnosc_tarczycy', 'powiekszenie_watroby_a',
                                 'zastoinowa_niew_serca', 'udar_tia', 'mitral_regurgitation',
                                 'pochp_astma', 'heart_rate', 'stan_kliniczny_b', 
                                 'pogorszenie_chf_w_trakcie_leczenia', 'ablacja','klasa_nyha', 'klasa_nyha_a',
                                 'klasa_nyha_b', 'klasa_nyha_c', 'klasa_nyha_d',
                                 'status', 'czas_fu', 'wiek', 'zastoinowa_ns_od_ilu_lat', 'nadcisnienie_tetnicze_od_ilu_lat',
                                 'dekompensacja_ile_razy',
                                 'nie_pali_od_lat', 'palil_pali_przez_lat', 'cukrzyca_od_ilu_lat', 'dusznosc_a_od_ilu_dni',
                                 'waga_ciala_a', 'hgb_a_przyjecie', 'hct_a', 'rbc_a', 'wbc_a', 'mono_a_percent', 'lymph_a_percent',
                                 'neutr_a_percent', 'na_sod_a', 'mocznik_a', 'glukoza_a', 'crp_a', 'albuminy_a', 'troponina_i_a'))

as.factor(survival$status)
survival$czas <- as.numeric(survival$czas_fu)

#qualitative variables for survival analysis
qualitative = c('plec',
                'Etiologia',
                'dekompensacja_de_novo_w_pns',
                'choroba_niedokrwienna', 'ostre_zapalenie_wiencowe', 'dekompensacja',
                'profil_hemodynamiczny', 'przewlekla_niewydolnosc_nerek',
                'nadcisnienie_tetnicze', 'wady_zastawkowe', 'zaburzenia_rytmu_serca',
                'choroby_watroby', 'nikotynizm', 'alkohol',
                'cukrzyca', 'spadek_tolerancji_wysilku', 'dusznosc_spoczynkowa_a', 'zaburzenia_lipidowe',
                'niedoczynnosc_tarczycy', 'powiekszenie_watroby_a',
                'zastoinowa_niew_serca', 'udar_tia', 'mitral_regurgitation', 'pochp_astma', 'heart_rate', 'stan_kliniczny_b', 
                'pogorszenie_chf_w_trakcie_leczenia', 'ablacja','klasa_nyha', 'klasa_nyha_a',
                'klasa_nyha_b', 'klasa_nyha_c', 'klasa_nyha_d')

qualitative <- as.factor(qualitative)

#quantitative variables for descriptive statistics
quantitative = c('wiek', 'zastoinowa_ns_od_ilu_lat', 'nadcisnienie_tetnicze_od_ilu_lat', 'dekompensacja_ile_razy',
                'nie_pali_od_lat', 'palil_pali_przez_lat', 'cukrzyca_od_ilu_lat',
                'dusznosc_a_od_ilu_dni','waga_ciala_a', 'hgb_a_przyjecie', 'hct_a', 'rbc_a', 'wbc_a', 'mono_a_percent', 'lymph_a_percent',
                 'neutr_a_percent', 'na_sod_a', 'mocznik_a', 'glukoza_a', 'crp_a', 'albuminy_a', 'troponina_i_a')


