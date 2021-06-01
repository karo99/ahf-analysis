
ui <- dashboardPage(
    title = "Acute Heart Failure Analysis",
    
    dashboardHeader(
        titleWidth = 270,
        title = shinyDashboardLogo(
            theme = "blue_gradient",
            boldText = "Acute Heart Failure",
            mainText = "Analysis"
    )),
    
    dashboardSidebar(
        width = 270,
        sidebarMenu(
            menuItem("O aplikacji", tabName = "appInfo", icon = icon("info")),
            menuItem("Zbiór danych", tabName = "dataset", icon = icon("table")),
            menuItem("Ostra niewydolność serca", tabName = "disease", icon = icon("heartbeat")),
            menuItem("Analiza przeżycia", tabName = "survival", icon = icon("chart-line"),
                     menuSubItem("Krzywa Kaplana-Meiera", tabName = "survival-km"),
                     menuSubItem("Model regresji Coxa", tabName = "survival-cox")),
            menuItem("Statystyki pacjentów", tabName = "statistics", icon = icon("bar-chart"),
                     menuSubItem("Histogram", tabName = "statistics-hist"),
                     menuSubItem("Wykres pudełkowy", tabName = "statistics-box")),
            menuItem("Podsumowanie", tabName = "summary", icon = icon("file-medical-alt"))
        )
    ),
    dashboardBody(
        tags$style(HTML(".content-wrapper {overflow-y: auto; max-height: 90vh}")),
        shinyDashboardThemes(
            theme = "blue_gradient"
        ),
        
        tabItems(
            
            tabItem(tabName = "appInfo",
                    h2("O aplikacji", style = 'font-family: "Montserrat Light'),
                    
                    column(width = 12,
                           box(
                               style = 'margin-top: 15px',
                               width = NULL,
                               h4("Cel", align = "center", style = 'font-family:
                                  "Montserrat"; color:white'),
                               background = "yellow",
                               p("Aplikacja", em("Acute Heart Failure Analysis"),
                                 "umożliwia użytkownikowi dostęp do szerokiego
                                 spektrum wizualizacji danych pacjentów z ostrą niewydolnością serca",
                                 em("(ONS, ang. acute heart failure)."),
                                 "Główny nacisk stawia na analizę przeżycia pacjentów z tą jednostką
                                 chorobową, ale skupia się także na pokazaniu jakie parametry czy
                                 cechy organizmu są dla niej istotne.",
                                 style = 'text-align: center'
                           )),
                           
                           box(
                               width = NULL,
                               background = "teal",
                               h4("Funkcjonalności", align = "center", style = 'font-family:
                                  "Montserrat"; color:white'),
                               
                               "Aplikacja zapewnia kilka paneli graficznych: ", br(),
                               
                               "1.", strong("Zbiór danych -"),
                               "są to dane zebrane od 250 pacjentów, przedstawione
                               w formie tabelarycznej za pomocą ponad 400 kolumn. Możliwe jest
                               pokazywanie odpowiedniej ilości rekordów, przewijanie stron z danymi oraz
                               filtrowanie kolumn pod względem wartości tam się znajdujących.
                               ", br(),
                               
                               "2.", strong("Ostra niewydolność serca -"),
                               "znajduje się tu krótka charakterystyka ostrej niewydolności
                               serca pod względem przyczyn i objawów tej choroby.", br(),
                               
                               "3.", strong("Analiza przeżycia -"), "bada czas jaki minie od
                               przyjęcia pacjenta do szpitala do
                                zgonu pacjenta. Uwzględnia obserwacje cenzurowane, czyli takie
                                w których pacjent będący w szpitalu nie zmarł, dostał wypis i
                                niewiadomo o jego dalszych losach. W menu rozwijanym
                               dostępne są różne metody analizy przeżycia.", br(),
                               
                               p("a.", strong("Krzywe Kaplana-Meiera -"),
                                 "krzywe przeżycia są konstruowane na podstawie estymatora
                                 Kaplana-Meiera. Pokazuje on procent przeżywalności
                                 pacjentów w miarę upływu dni. Model ten może być zależny od
                                 czynnika jakościowego takiego jak płeć, spożywanie 
                                 alkoholu czy posiadanie nadciśnienia tętniczego.",
                                 style = 'padding-left: 10px', br(),
                                 
                               "b.", strong("Model regresji Coxa -"),
                               "jest to inaczej model proporcjonalnego hazardu
                               Coxa i umożliwia on opisanie krzywej przeżycia. Również
                               jest zależny od czynnika jakościowego lub także ilościowego 
                               np. wieku czy wagi pacjenta. W panelu przedstawiony jest test Schoenfelda
                               zapewniający graficzną ocenę założeń modelu Coxa i dzięki niemu
                               można zobaczyć jak beta, czyli wektor współczynników
                               modelu, zmienia się w czasie pomiędzy wybranymi czynnikami i 
                               jednocześnie jaki ma wpływ na funkcję ryzyka."),
                               
                               "4.", strong("Statystyki pacjentów -"), 
                               "istotne jest zwizualizowanie i dostrzeżenie zależności
                               pomiędzy różnymi czynnikami mogącymi mieć wpływ na
                               rozwój ONS u pacjentów. W menu rozwijanym dostępne są
                               różne opcje związane z wizualizacją danych pacjentów.",
                               br(),
                               
                               p("a.", strong("Histogram -"),
                                 "przedstawia rozkład empiryczny wybranego czynnika
                                 ilościowego.",
                                 style = 'padding-left: 10px', br(),
                                 
                                 "b.", strong("Wykresy pudełkowe -"),
                                 "po wybraniu dwóch zmiennych - zmiennej jakościowej
                                 oraz zmiennej ilościowej, konstruowany jest wykres
                                 pudełkowy", em("( ang. boxplot"), "z zaznaczonymi
                                 pierwszym i trzecim kwartylem oraz medianą"),
                               
                               "5.", strong("Podsumowanie -"), 
                               "znajdują się tutaj standardowe statystyki opisowe dla wybranego
                               parametru, np. wagi ciała, lat palenia czy poziomu
                               hemoglobiny."
                               )
                           )
                    
            ),
            
            tabItem(tabName = "dataset",
                    h2("Zbiór danych", style = 'font-family: "Montserrat Light'),
                    box(dataTableOutput('table'), width = 50, tags$style(HTML(
                        ".dataTables_scrollBody {height: 45vh}",".sorting {white-space:nowrap}")))
                    
            ),
            
            tabItem(tabName = "disease",
                    h2("Ostra niewydolność serca", style = 'font-family: "Montserrat Light'),
                    box(style = 'margin-top: 15px',
                        width = 12,
                        background = "yellow",
                        fluidRow(
                            column(
                                width = 12,
                                p(strong("Ostra niewydolność serca"), em("(ang. acute heart failure)"),
                                  " jest to jedna z postaci niewydolności serca, charakteryzująca się
                        nagłym pogorszeniem jej objawów."),
                                p(strong("Definicja"), br(),
                                  "Można ją definiować jako upośledzenie
                        czynności serca, prowadzących do stanu niedostatku tlenu i substancji 
                        odżywczych w komórkach serca. U pacjentów występuje ", em("de novo"),
                                  "bądź jako dekompensacja przewlekłej niewydolności serca."),
                                strong("Etiologia - przykładowe przyczyny powstania"),
                                p(
                                    "Dekompensacja przewlekłej niewydolności serca", br(),
                                    "Choroba niedokrwienna serca", br(),
                                    "Niedomykalność zastawki", br(),
                                    "Nadciśnienie tętnicze", br(),
                                    "Choroby mięśnia sercowego", br(),
                                    "Astma", br(),
                                    "Nadmierne spożywanie alkoholu", br(),
                                    "Udar mózgu", br(),
                                    "Brak odpowiedniego leczenia",
                                    style = 'padding-left: 10px'),
                                strong("Przykładowe objawy"), br(),
                                p(
                                    "Zwiększenie masy ciała", br(),
                                    "Niskie ciśnienie tętna", br(),
                                    "Zimna skóra i kończyny", br(),
                                    "Tętno nitkowate", br(),
                                    "Duszności",
                                    style = 'padding-left: 10px'
                                ),
                                p(
                                    "Źródła:  Anna Praska-Ogińska, Janusz Bednarski,",
                                    em("Leczenie Ostrej niewydolności serca, "),
                                    "Folia Cardiologica 2017",
                                    style = 'font-size: 12px; color: lightgrey'
                                    
                                )
                            )
                        )
                        
                        
            )),
            
            tabItem(tabName = "survival-km",
                    h2("Krzywa przeżycia Kaplana-Meiera", style = 'font-family: "Montserrat Light'),
                    selectInput(
                        "variablesKm",
                        label = "Wybierz czynnik",
                        choices = qualitative),
                    plotOutput(outputId = 'surv_plot'),
                    box(
                        title = "Podsumowanie",
                        background = "teal",
                        solidHeader = TRUE,
                        width = 600,
                        # height = 100,
                        verbatimTextOutput("summaryDset"))
            ),
            
            tabItem(tabName = "survival-cox", h2("Model Coxa", style = 'font-family: "Montserrat Light'),
                    selectInput(
                        "variablesCox",
                        label = "Wybierz czynnik",
                        choices = qualitative),
                    plotOutput(outputId = 'cox_plot'),
                    box(
                        title = "Podsumowanie",
                        solidHeader = TRUE,
                        background = "teal",
                        width = 600,
                        # height = 100,
                        verbatimTextOutput("summaryTest"))
            ),
            
            tabItem(tabName = "statistics-hist",
                    h2("Histogram", style = 'font-family: "Montserrat Light'),
                    box(selectInput(
                        "variableQuant1",
                        label = "Wybierz zmienną X",
                        choices = quantitative),
                        plotOutput(outputId = 'histPlot'),width = 50,
                        tags$style(HTML("align: 'center'")))
            ),
            
            
            tabItem(tabName = "statistics-box",
                    h2("Wykres pudełkowy", style = 'font-family: "Montserrat Light'),
                    box(selectInput(
                        "variableQuali",
                        label = "Wybierz zmienną X",
                        choices = qualitative),
                        selectInput(
                            "variableQuant",
                            label = "Wybierz zmienną Y",
                            choices = quantitative),
                        plotOutput(outputId = 'boxPlot'),width = 50,
                        tags$style(HTML("align: 'center'")))
            ),
            
            tabItem(
                tabName = "summary",
                h2("Statystyki opisowe", style = 'font-family: "Montserrat Light'),
                selectInput(
                    "variablesSum",
                    label = "Wybierz parametr",
                    choices = quantitative),
                box(
                    title = "Podsumowanie",
                    background = "teal",
                    solidHeader = TRUE,
                    maxwidth = 50,
                    verbatimTextOutput("summaryVar"))
            )
            
        ),
        tags$head(includeCSS("www/CSS.css"))
    )
    )


