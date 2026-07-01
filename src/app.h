#ifndef APP
#define APP

// modos da aplicacao, pode estar no menu ou no modo de simulacao
typedef enum App {
    MENU,
    SIMULATION
} App;

void initApp(App app) {
    if (!app) {
        // MENU

    } else {
        // SIM
        
    }
}

#endif
