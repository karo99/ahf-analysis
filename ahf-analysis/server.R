
server <- function(input, output) {
    
    output$table <- renderDataTable(myData,
                                    options = list(
                                        scrollX = TRUE
                                    ))
    output$surv_plot <- renderPlot({

        survival %>% select(input$variablesKm) %>% filter(!is.na(input$variablesKm))
        
        fit <- eval(parse(text = paste0("survfit(Surv(czas, status) ~", input$variablesKm, ", data = survival)")))
        
        if (input$variablesKm == "Etiologia"){
            ggsurvplot(fit, xlab = "Days", ylab = "Overall survival probability", pval = TRUE,
                       ggtheme = theme_classic2(
                           base_size = 10, base_family = "Arial")
                       )
        } else {
            ggsurvplot(fit, xlab = "Days", ylab = "Overall survival probability", pval = TRUE, risk.table = TRUE,
                       tables.theme = theme_cleantable(), ggtheme = theme_classic2(
                           base_size = 10, base_family = "Arial")
            )
        }
    })
    
    output$summaryDset <- renderPrint({
        fit <- eval(parse(text = paste0("survfit(Surv(czas, status) ~", input$variablesKm, ", data = survival)")))
        summary(fit)
    })
    
    output$cox_plot <- renderPlot({
        res.cox <- eval(parse(text = paste0("coxph(Surv(czas, status) ~", input$variablesCox, ", data = survival)")))
        test.ph <- cox.zph(res.cox)
        ggcoxzph(test.ph)
    })
    
    output$summaryTest <- renderPrint({
        res.cox <- eval(parse(text = paste0("coxph(Surv(czas, status) ~", input$variablesCox, ", data = survival)")))
        res.cox
    })
    
    output$histPlot <- renderPlot({
        
        p <- eval(parse(text = paste0('ggplot(data = survival, aes(x=', input$variableQuant1,')) +
            geom_histogram( fill ="#69b3a2", color="#e9ecef", alpha=0.9) +  theme_ipsum()')))
        p
    })
    
    
    output$boxPlot <- renderPlot({
        
        p <- eval(parse(text = paste0('ggplot(data = survival, aes(x=',
        input$variableQuali, ', y=', input$variableQuant, ')) +
            geom_boxplot(color="#69b3a2") + theme_ipsum() + theme( legend.position="none")+
            xlab("") + scale_x_discrete(na.translate = FALSE)')))
        p
    })
    
    output$summaryVar <- renderPrint({

        variables <- get(input$variablesSum, survival)
        variables <- na.omit(variables)
        summary(variables)
    })
}
