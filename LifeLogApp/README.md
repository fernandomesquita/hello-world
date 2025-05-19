# LifeLogApp

Este é um exemplo simples de app para iPhone escrito em SwiftUI. Ele permite digitar um texto (ou deixar em branco) e registra a entrada com data e coordenadas de GPS.

Para testar:
1. Abra o `LifeLogApp.swift` em um projeto Xcode vazio.
2. Adicione o `Info.plist` ao projeto e verifique se a chave `NSLocationWhenInUseUsageDescription` está presente.
3. Execute em um dispositivo ou simulador com permissões de localização.

Quando você pressiona o botão **Salvar Entrada**, o app captura sua localização atual e adiciona a entrada a uma lista visível na tela.
