local L = LibStub("AceLocale-3.0"):NewLocale("ControlFreak", "ptBR")
if not L then
	return
end

--------------------------------------------------------------------------------
-- Identity
--------------------------------------------------------------------------------

L["ADDON_TITLE"] = "Control Freak"
L["OPTIONS_DESCRIPTION"] = "Informação melhor = tanque melhor. Tanque melhor = raides melhores."
L["VERSION"] = "Versão"

--------------------------------------------------------------------------------
-- Chat Messages
--------------------------------------------------------------------------------

L["CHAT_LOADED"] =
	"Versão %s. As configurações (incluindo a opção de desativar esta mensagem) estão em Opções > AddOns > Control Freak. Curtiu o addon? Conta pra um amigo! (="
L["CHAT_OPTIONS_IN_COMBAT"] = "Por precaução, a Interface de Opções não pode ser aberta durante o combate."

--------------------------------------------------------------------------------
-- General Panel
--------------------------------------------------------------------------------

L["ENABLE_WELCOME_MESSAGE"] = "Ativar mensagem de boas-vindas"
L["ENABLE_WELCOME_MESSAGE_DESC"] = "Mostra a saudação do Control Freak quando você entra no jogo."
L["ENABLE_MINIMAP_BUTTON"] = "Ativar botão do minimapa"
L["ENABLE_MINIMAP_BUTTON_DESC"] = "Mostra o botão do Control Freak no seu minimapa."

L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/freak"
L["OPTIONS_COMMAND_DESCRIPTION"] = "Abre a Interface de Opções deste addon."

-- The master switch. Its description is shared with the mini-map button's own
-- line for the same toggle, so the two cannot describe it differently.
L["KILL_SWITCH"] = "Chave geral"
L["KILL_SWITCH_ENABLE"] = "Ativar Control Freak"
L["KILL_SWITCH_ENABLE_DESC"] = "Liga ou desliga todos os alertas do Control Freak."

L["FEEDBACK_HEADER"] = "Comentários e suporte"
L["FEEDBACK_DISCORD"] = "Discord"
L["FEEDBACK_GITHUB"] = "GitHub"
L["FEEDBACK_CURSEFORGE"] = "CurseForge"
L["FEEDBACK_WAGO"] = "Wago"

--------------------------------------------------------------------------------
-- Mini-map Button
--------------------------------------------------------------------------------

L["STATE_ON"] = "Ligado"
L["STATE_OFF"] = "Desligado"
L["LEFT_CLICK"] = "Clique esquerdo"
L["RIGHT_CLICK"] = "Clique direito"
L["SHIFT_MIDDLE_CLICK"] = "Shift + clique do meio"
L["ACTION_TOGGLE"] = "Alternar"
L["MINIMAP_OPTIONS"] = "Opções do Control Freak"

--------------------------------------------------------------------------------
-- Feature Tabs
--------------------------------------------------------------------------------

L["TAB_TAUNTS"] = "Provocações"
L["TAB_INTERRUPTS"] = "Interrupções"
L["TAB_FEARS"] = "Medos"
L["TAB_BAD_PET"] = "Mascote danada"
L["TAB_TANKING_TOOLS"] = "Ferramentas de tanque"

--------------------------------------------------------------------------------
-- Feature Scope
--------------------------------------------------------------------------------

L["SCOPE_ENABLE_DESC"] = "Liga ou desliga este recurso."
L["SCOPE_TANK_ROLE_ONLY"] = "Só quando você joga de tanque"
L["SCOPE_TANK_ROLE_ONLY_DESC"] =
	"Só dispara enquanto você estiver tanqueando, seja como Tanque principal do raide ou com a função de Tanque marcada no localizador de grupo. Sem nenhum dos dois, este recurso fica quieto."
L["SCOPE_GROUP_HAS_TANK"] = "Só quando o grupo tem tanque"
L["SCOPE_GROUP_HAS_TANK_DESC"] =
	"Só dispara enquanto alguém do seu grupo estiver tanqueando e ainda vivo. Um tanque caído conta como nenhum tanque, porque é justamente aí que ajuda ter outra pessoa segurando a ameaça."
L["SCOPE_INSTANCE_ONLY"] = "Só dentro de instâncias"
L["SCOPE_INSTANCE_ONLY_DESC"] = "Só dispara dentro de masmorras e raides."

--------------------------------------------------------------------------------
-- Alert Sections
--------------------------------------------------------------------------------

--[[
    Every alert on every tab is drawn as the same block, so each one owns three
    strings: a HEADER naming the thing that happened, an ENABLE reading "Enable
    <that thing> Notifications" -- the switch turns the telling on, not the event
    -- and a DESC of one or two sentences. ns.AddAlertSection in
    Options-Utilities.lua is where that shape lives.

    TRANSLATORS: the two SCOPE_DESC tooltips below quote the dropdown's own
    choices by name. Those quoted words must match your translations of
    ALERT_SCOPE_MINE and ALERT_SCOPE_ALL, or the tooltip explains options the
    player cannot find in the list.
]]
L["ALERT_SECTION_ENABLE_DESC"] = "Liga ou desliga este alerta."
L["ALERT_PRINT"] = "Exibir notificações"
L["ALERT_PRINT_DESC"] = "Exibe este alerta na sua própria janela de bate-papo."
L["ALERT_PRINT_SCOPE_DESC"] =
	"De quem são as conjurações que chegam na sua janela. Minhas cobre você e a sua própria mascote; Todas cobre todo mundo do seu grupo. O som também segue esta escolha, então você nunca ouve um alerta que não pode ver."
L["ALERT_ANNOUNCE"] = "Anunciar ao grupo"
L["ALERT_ANNOUNCE_DESC"] =
	"Manda este alerta para o bate-papo do seu grupo ou raide. Narrar o que os outros fazem para o raide inteiro é o jeito mais rápido de um addon cansar todo mundo, então vale pensar antes de ligar este aqui."
L["ALERT_ANNOUNCE_SCOPE_DESC"] =
	"De quem são as conjurações que vão para o bate-papo do grupo ou raide. Minhas cobre você e a sua própria mascote; Todas cobre todo mundo do seu grupo, você incluído."
L["ALERT_SCOPE_MINE"] = "Minhas"
L["ALERT_SCOPE_ALL"] = "Todas"
L["ALERT_BOSS_ONLY"] = "Só contra chefes e elites"
L["ALERT_BOSS_ONLY_DESC"] =
	"Só dispara contra inimigos que merecem atenção: chefes de raide, chefes de masmorra e qualquer elite acima do seu próprio nível."
L["ALERT_SOUND"] = "Som"
L["ALERT_SOUND_DESC"] = "Toca um som quando este alerta dispara."
L["ALERT_SOUND_FILE_DESC"] = "Escolha o som que este alerta toca. Escolher um já toca."
L["ALERT_SOUND_PREVIEW_DESC"] = "Toca este som agora, com o som ligado ou não."
L["SOUND_NONE"] = "Nenhum"

-- The cooldown dropdown's own entries, built by ns.BuildCooldownValues from a
-- list of seconds. Whole minutes read as minutes, and zero reads as "No
-- Cooldown" rather than "0 Second Cooldown".
L["COOLDOWN_NONE"] = "Sem recarga"
L["COOLDOWN_SECONDS"] = "Recarga de %d segundos"
L["COOLDOWN_MINUTES"] = "Recarga de %d minutos"

--------------------------------------------------------------------------------
-- Sample Lines
--------------------------------------------------------------------------------

--[[
    The "Example:" line under a block is NOT written here. It is rendered from the
    real message format below with these stand-in names, so a reworded alert
    cannot leave a hand-copied example quoting the old text. The names are
    translatable because they sit inside a sentence whose grammar a locale may
    want to agree with.
]]
L["SAMPLE_EXAMPLE"] = "Exemplo: %s"
L["SAMPLE_PLAYER"] = "Gogo"
L["SAMPLE_OTHER"] = "João"
L["SAMPLE_PET"] = "Bidu"

--------------------------------------------------------------------------------
-- Ability Lists
--------------------------------------------------------------------------------

L["ABILITIES_ITEMS"] = "Itens"
L["ABILITIES_CLASS_PET"] = "Mascote de %s"

--------------------------------------------------------------------------------
-- Taunts
--------------------------------------------------------------------------------

L["TAUNTS_SUMMARY"] = "Provocações são habilidades que tiram a ameaça de quem estiver com ela no momento."
L["TAUNTS_ENABLE"] = "Ativar monitoramento de provocações"

L["TAUNTS_SUCCESS_HEADER"] = "Provocações bem-sucedidas"
L["TAUNTS_SUCCESS_ENABLE"] = "Ativar notificações de provocações bem-sucedidas"
L["TAUNTS_SUCCESS_DESC"] =
	"Uma provocação que pegou e tirou o inimigo de outra pessoa. Uma provocação num inimigo que já estava batendo em quem provocou é uma renovação de ameaça, não um resgate, então essas ficam quietas."
L["TAUNTS_FAILED_HEADER"] = "Provocações falhas"
L["TAUNTS_FAILED_ENABLE"] = "Ativar notificações de provocações falhas"
L["TAUNTS_FAILED_DESC"] =
	"Uma provocação que errou, foi resistida ou acertou algo imune. O inimigo não trocou de dono, e nada na tela avisa isso."
L["TAUNTS_AOE_HEADER"] = "Provocações em área"
L["TAUNTS_AOE_ENABLE"] = "Ativar notificações de provocações em área"
L["TAUNTS_AOE_DESC"] = "Uma provocação que agarra tudo em volta de uma vez, em vez de um alvo só."

L["TAUNTS_ABILITIES_HEADER"] = "Habilidades de provocação"
L["TAUNTS_AOE_ABILITIES_HEADER"] = "Habilidades de provocação em área"

--------------------------------------------------------------------------------
-- Interrupts
--------------------------------------------------------------------------------

L["INTERRUPTS_SUMMARY"] = "Interrupções param uma magia inimiga no meio da conjuração."
L["INTERRUPTS_ENABLE"] = "Ativar monitoramento de interrupções"

L["INTERRUPTS_ALERT_HEADER"] = "Interrupções bem-sucedidas"
L["INTERRUPTS_ALERT_ENABLE"] = "Ativar notificações de interrupções bem-sucedidas"
L["INTERRUPTS_ALERT_DESC"] = "Uma conjuração parada no meio. Diz quem parou e o que foi parado."

--------------------------------------------------------------------------------
-- Fears
--------------------------------------------------------------------------------

L["FEARS_SUMMARY"] = "Medos fazem os inimigos sair correndo e espalham uma puxada pela sala inteira."
L["FEARS_ENABLE"] = "Ativar monitoramento de medos"

L["FEARS_ALERT_HEADER"] = "Medos"
L["FEARS_ALERT_ENABLE"] = "Ativar notificações de medos"
L["FEARS_ALERT_DESC"] =
	"Um medo que pegou e espalhou a puxada para fora do alcance do tanque. Só conta quando pega: uma conjuração sem efeito, uma resistência e uma imunidade não moveram nada, então nenhuma delas é relatada."

L["FEARS_ABILITIES_HEADER"] = "Habilidades de medo"

--------------------------------------------------------------------------------
-- Bad Pet
--------------------------------------------------------------------------------

-- The summary doubles as the mini-map button's Bad Pet line, so the tab and the
-- tooltip cannot describe the feature differently.
L["BAD_PET_SUMMARY"] =
	"Mascotes de caçador e de bruxo com habilidades de ameaça deixadas em conjuração automática."
L["BAD_PET_ENABLE"] = "Ativar monitoramento de mascotes danadas"

L["BAD_PET_ALERT_HEADER"] = "Provocações de mascote"
L["BAD_PET_ALERT_ENABLE"] = "Ativar notificações de provocações de mascote"
L["BAD_PET_ALERT_DESC"] =
	"Uma mascote tirando o inimigo do tanque com a conjuração automática ligada, normalmente sem o dono perceber."
L["BAD_PET_WHISPER_ENABLE"] = "Sussurrar ao dono"
L["BAD_PET_WHISPER_ENABLE_DESC"] =
	"Manda ao dono da mascote um recado explicando como desligar a conjuração automática. Só um é enviado mesmo quando várias pessoas do seu grupo usam o Control Freak."
L["BAD_PET_COOLDOWN_DESC"] =
	"Quanto tempo uma mascote fica quieta depois de disparar um alerta. Vale para a mensagem, o som, o anúncio e o sussurro, para que uma mascote com a conjuração automática ligada não encha a sua janela e o dono dela não receba um sussurro a cada poucos segundos."

L["BAD_PET_ABILITIES_HEADER"] = "Habilidades de mascote danada"

--------------------------------------------------------------------------------
-- Tanking Tools
--------------------------------------------------------------------------------

-- No summary line: the Tanking Tools tab opens on its enable, because the tab is
-- a collection of unrelated warnings rather than one idea a sentence can cover.
-- Each section introduces itself instead.
L["TANKING_TOOLS_ENABLE"] = "Ativar ferramentas de tanque"

L["TANKING_TOOLS_COLD_OPENER_HEADER"] = "Aberturas frias"
L["TANKING_TOOLS_COLD_OPENER_ENABLE"] = "Ativar notificações de aberturas frias"
L["TANKING_TOOLS_COLD_OPENER_DESC"] =
	"Avisa sobre os seus próprios ataques de abertura que não pegaram: um erro, uma esquiva, um aparo, um bloqueio, uma resistência ou uma imunidade nos primeiros segundos de uma puxada. Ameaça que nunca aconteceu, bem na hora em que ela mais importa."
L["TANKING_TOOLS_COLD_OPENER_WINDOW_DESC"] =
	"Até que ponto de uma puxada uma habilidade evitada ainda conta. O relógio começa na primeira vez que o Control Freak vê aquele inimigo, e só habilidades contam: um ataque automático erra vezes demais para virar notícia."
L["TANKING_TOOLS_COLD_OPENER_WINDOW"] = "%d segundos de luta"

L["TANKING_TOOLS_ARMOR_HEADER"] = "Reduções de armadura"
L["TANKING_TOOLS_ARMOR_ENABLE"] = "Ativar notificações de reduções de armadura"
L["TANKING_TOOLS_ARMOR_DESC"] =
	"Relata quanto tempo o grupo levou para descascar a armadura de um alvo: cinco Rasgar Armadura ou um Expor Armadura de ladino. Ligue um extra abaixo e ele também espera por esse, mas só quando alguém do grupo puder mesmo conjurá-lo."
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE"] = "Incluir Fogo Feérico"
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE_DESC"] =
	"Espera por Fogo Feérico antes de relatar, seja qual for a forma que o druida usar. Ignorado quando não há druida no grupo."
L["TANKING_TOOLS_ARMOR_RECKLESSNESS"] = "Incluir Maldição da Imprudência"
L["TANKING_TOOLS_ARMOR_RECKLESSNESS_DESC"] =
	"Espera por Maldição da Imprudência antes de relatar. Ignorado quando não há bruxo no grupo."

L["TANKING_TOOLS_PARRY_HEADER"] = "Aparos"
L["TANKING_TOOLS_PARRY_ENABLE"] = "Ativar notificações de aparos"
L["TANKING_TOOLS_PARRY_DESC"] =
	"Quem é aparado por um inimigo que não está tanqueando está parado na frente dele. Cada aparo acelera o próximo golpe daquele inimigo contra quem está segurando ele."
L["TANKING_TOOLS_PARRY_WHISPER"] = "Sussurrar ao culpado"
L["TANKING_TOOLS_PARRY_WHISPER_DESC"] =
	"Manda ao culpado um recado pedindo que ele fique atrás do inimigo. Só um é enviado mesmo quando várias pessoas do seu grupo usam o Control Freak."
L["TANKING_TOOLS_PARRY_COOLDOWN_DESC"] =
	"Quanto tempo um culpado fica quieto depois de disparar um aviso de aparo. Vale para a mensagem, o som, o anúncio e o sussurro, porque quem ainda não se moveu não precisa ouvir isso a cada golpe."

L["TANKING_TOOLS_NOVA_HEADER"] = "Novas de Gelo"
L["TANKING_TOOLS_NOVA_ENABLE"] = "Ativar notificações de Novas de Gelo"
L["TANKING_TOOLS_NOVA_DESC"] = "Avisa sobre uma Nova de Gelo, que espalha uma puxada para fora do alcance do tanque."

--------------------------------------------------------------------------------
-- Message Formats
--------------------------------------------------------------------------------

L["UNKNOWN_SOURCE"] = "Alguém"
L["UNKNOWN_TARGET"] = "um alvo desconhecido"
L["UNKNOWN_SPELL"] = "uma magia desconhecida"

L["TAUNT_SUCCESS"] = "Provocação! %s usou %s em %s!"
L["TAUNT_AOE"] = "Provocação em área! %s usou %s!"
L["TAUNT_MISSED"] = "Provocação falhou! %s usou %s em %s e errou!"
L["TAUNT_RESISTED"] = "Provocação falhou! %s usou %s em %s e foi resistida!"
L["TAUNT_IMMUNE"] = "Provocação falhou! %s usou %s em %s sem efeito! %s está imune."
L["TAUNT_FAILED"] = "Provocação falhou! %s usou %s em %s sem efeito!"
L["TAUNT_STOLEN"] = "Ei, esse é meu! %s usou %s em %s!" -- parked; see Data/Default-Settings.lua

L["FEAR_SUCCESS"] = "Medo! %s usou %s em %s!"
L["FEAR_AOE"] = "Medo em área! %s usou %s!"

L["INTERRUPT"] = "Interrupção! %s usou %s em %s para parar %s!"

L["COLD_OPENER_MISS"] = "Cuidado! %s usou %s e errou %s!"
L["COLD_OPENER_DODGE"] = "Cuidado! %s usou %s e %s esquivou!"
L["COLD_OPENER_PARRY"] = "Cuidado! %s usou %s e %s aparou!"
L["COLD_OPENER_BLOCK"] = "Cuidado! %s usou %s e %s bloqueou!"
L["COLD_OPENER_IMMUNE"] = "Cuidado! %s usou %s e %s estava imune!"
L["COLD_OPENER_RESIST"] = "Cuidado! %s usou %s e %s resistiu!"

L["ARMOR_REPORT"] = "Armadura de %s descascada depois de %s segundos!"

L["PARRY_WARNING"] = "Pressa de aparo! %s está na frente de %s!"
L["PARRY_WHISPER"] =
	"Ei, fica atrás de %s, por favor. Por causa da pressa de aparo você está me fazendo tomar mais dano."

L["NOVA"] = "Nova! %s usou %s em %s!"
L["NOVA_AOE"] = "Nova em área! %s usou %s!"
-- parked with the bubbles themselves; still reads "Annoyance!" and wants wording
-- of its own when Bubble Warnings lands. See Data/Abilities.lua.
L["ANNOYANCE_BUBBLE"] = "Que chatice! %s usou %s em %s com %d%% de vida!"

L["BAD_PET"] = "Mascote danada! A mascote de %s, %s, usou %s em %s!"
L["BAD_PET_AOE"] = "Mascote danada! A mascote de %s, %s, usou %s!"
L["BAD_PET_OWN"] = "Mascote danada! A sua mascote %s usou %s em %s!"
L["BAD_PET_OWN_AOE"] = "Mascote danada! A sua mascote %s usou %s!"
L["BAD_PET_UNKNOWN_OWNER"] = "Mascote danada! %s usou %s em %s!"
L["BAD_PET_UNKNOWN_OWNER_AOE"] = "Mascote danada! %s usou %s!"
L["BAD_PET_WHISPER"] =
	"A sua mascote %s usou %s em %s. Clique com o botão direito na habilidade na barra de ação da mascote ou no seu livro de feitiços para desligar a conjuração automática."
