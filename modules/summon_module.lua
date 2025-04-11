local SummonModule = {}

-- Estado e configurações iniciais
SummonModule.selectedBanner = "Standard Banner"

function SummonModule.setBanner(banner)
    SummonModule.selectedBanner = banner
    print("Banner selecionado: " .. banner)
end

-- Outras funções de estatísticas e configurações podem ser adicionadas aqui

return SummonModule