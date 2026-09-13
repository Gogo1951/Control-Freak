local L = LibStub("AceLocale-3.0"):NewLocale("ControlFreak", "ptBR")
if not L then
	return
end

--------------------------------------------------------------------------------
-- Identity
--------------------------------------------------------------------------------

L["ADDON_TITLE"] = "Control Freak"
L["OPTIONS_DESCRIPTION"] =
	"Anunciador de combate para provocações, interrupções, medos, mortes de tanque, ajudantes danados, aparos, reduções de armadura e outros eventos críticos da luta. Acompanhe quem provocou, o que falhou, quem interrompeu um lançamento e o que aconteceu, com alertas personalizáveis."
L["VERSION"] = "Versão"

--------------------------------------------------------------------------------
-- Chat Messages
--------------------------------------------------------------------------------

L["CHAT_LOADED"] =
	"Versão %s. As configurações (incluindo a opção de desativar esta mensagem) estão em Opções > AddOns > Control Freak. Curtiu o add-on? Conta pra um amigo! (="
L["CHAT_OPTIONS_IN_COMBAT"] = "Por segurança, a janela de opções não pode ser aberta durante o combate."

--------------------------------------------------------------------------------
-- General Panel
--------------------------------------------------------------------------------

L["ENABLE_WELCOME_MESSAGE"] = "Ativar mensagem de boas-vindas"
L["ENABLE_WELCOME_MESSAGE_DESC"] = "Mostra a saudação do Control Freak quando você entra no jogo."
L["ENABLE_MINIMAP_BUTTON"] = "Ativar botão do minimapa"
L["ENABLE_MINIMAP_BUTTON_DESC"] = "Mostra o botão do Control Freak no seu minimapa."

L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/freak"
L["OPTIONS_COMMAND_DESCRIPTION"] = "Abre a janela de opções deste add-on."

--[[
    The add-on's own switch, above every feature's. The title names its REACH
    rather than the act of throwing it, which is what a player cannot read off
    the box beside it -- every other toggle on this panel governs one thing.

    Its ENABLE description is shared with the mini-map button's line for the same
    toggle, so the two cannot describe it differently.
]]
L["KILL_SWITCH"] = "Todos os alertas"
L["KILL_SWITCH_SUMMARY"] =
	"Um único interruptor para todos os alertas de todas as abas: desligá-lo silencia o add-on sem alterar nenhuma configuração, e um clique esquerdo no botão do minimapa faz o mesmo de qualquer lugar."
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

--[[
    "Enabled" and "Disabled" rather than the shorter pair, matching the other
    add-ons in the family.
]]
L["STATE_ON"] = "Ativado"
L["STATE_OFF"] = "Desativado"
L["LEFT_CLICK"] = "Clique esquerdo"
L["RIGHT_CLICK"] = "Clique direito"
L["SHIFT_MIDDLE_CLICK"] = "Shift + clique do meio"
L["ACTION_TOGGLE"] = "Alternar"
L["MINIMAP_OPTIONS"] = "Opções do Control Freak"

--------------------------------------------------------------------------------
-- Feature Tabs
--------------------------------------------------------------------------------

-- In tab order.
L["TAB_TAUNTS"] = "Provocações"
L["TAB_INTERRUPTS"] = "Interrupções"
L["TAB_FEARS"] = "Medos"
L["TAB_INCAPACITATED"] = "Incapacitado"
L["TAB_TANK_DEATHS"] = "Mortes de tanque"
L["TAB_BAD_PRIESTS"] = "Sacerdotes danados"
L["TAB_BAD_PETS"] = "Ajudantes danados"
L["TAB_TANKING_TOOLS"] = "Arsenal do tanque"

--------------------------------------------------------------------------------
-- Feature Scope
--------------------------------------------------------------------------------

L["SCOPE_ENABLE_DESC"] = "Liga ou desliga este recurso."
--[[
    The dropdown beside every feature tab's enable, asking which seat the player
    has to be in. Always is the widest rung and the one most tabs ship on: it
    asks nothing about the seat at all.

    TRANSLATORS: these four sit beside a feature's enable and finish its sentence
    -- "Enable Incapacitation Monitoring" + "As a Tank" -- so they carry their
    own preposition rather than expecting one from the label, which lets each
    language put it where it belongs. They must also read on their own, since a
    closed dropdown shows the value without the label beside it. Keep them short:
    they share a 1.3-unit dropdown with "Elites Your Level+ & Bosses".
]]
L["SCOPE_ROLE_TANK"] = "Como tanque"
L["SCOPE_ROLE_HEALER"] = "Como curador"
L["SCOPE_ROLE_TANK_HEALER"] = "Como tanque ou curador"
L["SCOPE_ROLE_ALWAYS"] = "Sempre"
L["SCOPE_ROLE_DESC"] =
	"A função que você precisa ocupar para que este recurso diga alguma coisa. Você conta como tanque quando é o tanque principal do raide ou tem a função de Tanque selecionada no localizador de grupos, e como curador apenas quando tem a função de Curador selecionada, já que não existe uma atribuição de raide para cura. Sempre deixa a pergunta de lado e dispara seja qual for a sua função."
L["SCOPE_GROUP_HAS_TANK"] = "Quando o grupo tem tanque"
L["SCOPE_GROUP_HAS_TANK_DESC"] =
	"Só dispara enquanto alguém do seu grupo estiver tanqueando e ainda vivo. Um tanque caído conta como se não houvesse tanque, porque é justamente aí que ajuda ter outra pessoa segurando a ameaça."
L["SCOPE_INSTANCE_ONLY"] = "Dentro de instâncias"
L["SCOPE_INSTANCE_ONLY_DESC"] = "Só dispara dentro de masmorras e raides."

--------------------------------------------------------------------------------
-- Alert Sections
--------------------------------------------------------------------------------

--[[
    Every alert on every tab is drawn as the same block, so each one owns five
    strings: a HEADER naming the thing that happened; an ENABLE reading "Enable
    Notifications for <that thing> On" -- the switch turns the telling on, not
    the event, and the target dropdown beside it finishes the sentence, so the
    string ENDS on the preposition (a section with no target drops the word); a
    DESC of one or two sentences; and a MINE and an OTHERS naming the two rows.
    ns.AddWhoseAlertSection in Options-Alert-Section.lua is where that shape
    lives.

    The ENABLE is the longest label in the add-on and fits its column with
    little to spare, so keep translations short -- a longer one clips with an
    ellipsis.
]]
L["ALERT_SECTION_ENABLE_DESC"] = "Liga ou desliga este alerta."
L["ALERT_SOUND"] = "Tocar som"
L["ALERT_SOUND_DESC"] = "Toca um som quando este alerta dispara."
L["ALERT_SOUND_FILE_DESC"] = "Escolha o som que este alerta toca. Ao escolher um, ele já toca."
L["ALERT_SOUND_PREVIEW_DESC"] = "Toca este som agora, esteja o som ligado ou não."
L["SOUND_NONE"] = "Nenhum"

--[[
    The block every tab draws: whose cast is the row, where its line goes is
    the dropdown beside it, and the target filter is a ladder rather than a
    switch. Each section names its own two rows -- see
    TAUNTS_SUCCESS_MINE below -- because "My" and "Others'" agree with the noun
    in some languages and a shared "%s" template could not.

    TRANSLATORS: ALERT_AGAINST_DESC quotes one rung by name; that wording must
    match your TARGET_RUNG_ELITE_0, or the tooltip explains a choice the player
    cannot find in the list. The four rungs are a threshold, widest first: each
    one counts itself and the ones after it, which is why every rung that
    includes bosses says so. Keep that in your translations -- a rung reading
    only "Elites" beside a separate "Bosses" reads as two disjoint sets.

    ALERT_MARKED_ALWAYS is the one control that WIDENS a section rather than
    narrowing it: a marked target counts whatever the rung says. Keep "Always"
    in it, and keep it distinct from ALERT_OUTPUT_ANNOUNCE -- this row decides
    WHETHER the alert fires, never where its line goes.
]]
L["ALERT_MINE_DESC"] =
	"Relata as habilidades que você usa, incluindo as do seu ajudante. O menu ao lado diz para onde vai a linha."
L["ALERT_OTHERS_DESC"] =
	"Relata as habilidades usadas por todos os outros do seu grupo. O menu ao lado diz para onde vai a linha."
L["ALERT_OUTPUT_PRINT"] = "Exibir (só para mim)"
L["ALERT_OUTPUT_ANNOUNCE"] = "Anunciar"
L["ALERT_OUTPUT_DESC"] =
	"Para onde vai esta linha: um lugar só, nunca os dois. Exibir (só para mim) é a sua própria janela e não custa nada a ninguém. Anunciar, em vez disso, manda a linha para o bate-papo do grupo ou do raide, e narrar o que os outros fazem para o raide inteiro é como um add-on deixa de ser bem-vindo, então vale pensar duas vezes nessa. Anunciar fica em silêncio quando você não está em grupo, e também dentro de campos de batalha e arenas."
L["ALERT_AGAINST_DESC"] =
	'Quais inimigos contam; cada opção inclui as que vêm depois dela. Chefes são inimigos de nível caveira (??). Um chefe de masmorra não tem caveira própria, então conta como elite: "Elite do seu nível+ e chefes" é a opção que o mantém e deixa de fora os inimigos comuns de nível mais baixo ao redor dele. Uma marca de raide passa por cima de tudo isso enquanto a opção abaixo estiver ativada.'
L["TARGET_RUNG_ALL"] = "Tudo"
L["TARGET_RUNG_ELITE"] = "Elite e chefes"
L["TARGET_RUNG_ELITE_0"] = "Elite do seu nível+ e chefes"
L["TARGET_RUNG_BOSS"] = "Chefes"
L["ALERT_MARKED_ALWAYS"] = "Sempre avisar em alvos marcados"
L["ALERT_MARKED_ALWAYS_DESC"] =
	"Um alvo com marca de raide sempre conta, seja qual for a escolha no menu ao lado da opção de ativar: caveira, xis, qualquer uma das oito. Marcas são como o grupo aponta o que importa na puxada, então um alvo que alguém marcou nunca é descartado por não ter a categoria ou o nível certos."

--[[
    The cooldown dropdown's own entries, built by ns.BuildCooldownValues from a
    list of seconds. Whole minutes read as minutes, and zero reads as "No
    Cooldown" rather than "0 Second Cooldown".

    TRANSLATORS: one format serves every count it is given, one minute and five
    alike, so word each to read for any number. An abbreviated unit does.
]]
L["COOLDOWN_NONE"] = "Sem recarga"
L["COOLDOWN_SECONDS"] = "Recarga de %d s"
L["COOLDOWN_MINUTES"] = "Recarga de %d min"

--------------------------------------------------------------------------------
-- Sample Lines
--------------------------------------------------------------------------------

--[[
    Only the "Example:" frame is written here. The line inside it is rendered
    from the real message format below with these stand-in names, so a reworded
    alert cannot leave a hand-copied example quoting the old text. The names are
    translatable because they sit inside a sentence whose grammar a locale may
    want to agree with.
]]
L["SAMPLE_EXAMPLE"] = "Exemplo: %s"
L["SAMPLE_PLAYER"] = "Gogo"
L["SAMPLE_OTHER"] = "João"
L["SAMPLE_PET"] = "Bidu"

--[[
    The Naxxramas bosses the Example lines name, dealt one per line.

    TRANSLATORS: use each boss's name exactly as your client writes it, title
    included, not a translation of the English.
]]
L["SAMPLE_BOSS_ANUBREKHAN"] = "Anub'Rekhan"
L["SAMPLE_BOSS_FAERLINA"] = "Grã-viúva Faerlina"
L["SAMPLE_BOSS_MAEXXNA"] = "Maexxna"
L["SAMPLE_BOSS_NOTH"] = "Noth, o Pestífero"
L["SAMPLE_BOSS_HEIGAN"] = "Heigan, o Sujo"
L["SAMPLE_BOSS_LOATHEB"] = "Repugnaz"
L["SAMPLE_BOSS_RAZUVIOUS"] = "Instrutor Razúvio"
L["SAMPLE_BOSS_GOTHIK"] = "Gothik, o Ceifador"
L["SAMPLE_BOSS_MOGRAINE"] = "Grão-lorde Mograine"
L["SAMPLE_BOSS_KORTHAZZ"] = "Thane Korth'azz"
L["SAMPLE_BOSS_BLAUMEUX"] = "Lady Blaumeux"
L["SAMPLE_BOSS_ZELIEK"] = "Sir Zeliek"
L["SAMPLE_BOSS_PATCHWERK"] = "Retalhoso"
L["SAMPLE_BOSS_GROBBULUS"] = "Grobbulus"
L["SAMPLE_BOSS_GLUTH"] = "Gluth"
L["SAMPLE_BOSS_THADDIUS"] = "Thaddius"
L["SAMPLE_BOSS_SAPPHIRON"] = "Sapphiron"
L["SAMPLE_BOSS_KELTHUZAD"] = "Kel'Thuzad"

--------------------------------------------------------------------------------
-- Ability Lists
--------------------------------------------------------------------------------

L["ABILITIES_ITEMS"] = "Itens"
L["ABILITIES_CLASS_PET"] = "Ajudante de %s"

--------------------------------------------------------------------------------
-- Taunts
--------------------------------------------------------------------------------

L["TAUNTS_SUMMARY"] = "Provocações são habilidades que tiram a ameaça de quem estiver com ela no momento."
L["TAUNTS_ENABLE"] = "Ativar monitoramento de provocações"

L["TAUNTS_SUCCESS_HEADER"] = "Provocações bem-sucedidas"
L["TAUNTS_SUCCESS_DESC"] =
	"Uma provocação que pegou e tirou o inimigo de outra pessoa. Uma provocação em um inimigo que já estava batendo em quem provocou é uma renovação de ameaça, não um resgate, então essas ficam em silêncio."
L["TAUNTS_SUCCESS_ENABLE"] = "Avisar provocações bem-sucedidas contra"
L["TAUNTS_SUCCESS_MINE"] = "Minhas provocações bem-sucedidas"
L["TAUNTS_SUCCESS_OTHERS"] = "Provocações bem-sucedidas dos outros"

L["TAUNTS_FAILED_HEADER"] = "Provocações falhas"
L["TAUNTS_FAILED_DESC"] =
	"Uma provocação que errou, foi resistida ou acertou algo imune. O inimigo não trocou de dono, e nada na tela avisa isso."
L["TAUNTS_FAILED_ENABLE"] = "Avisar provocações falhas contra"
L["TAUNTS_FAILED_MINE"] = "Minhas provocações falhas"
L["TAUNTS_FAILED_OTHERS"] = "Provocações falhas dos outros"

L["TAUNTS_AOE_HEADER"] = "Provocações em área"
L["TAUNTS_AOE_DESC"] = "Uma provocação que agarra tudo ao redor de uma vez, em vez de um alvo só."
L["TAUNTS_AOE_ENABLE"] = "Avisar provocações em área"
L["TAUNTS_AOE_MINE"] = "Minhas provocações em área"
L["TAUNTS_AOE_OTHERS"] = "Provocações em área dos outros"

L["TAUNTS_ABILITIES_HEADER"] = "Habilidades de provocação"
L["TAUNTS_AOE_ABILITIES_HEADER"] = "Habilidades de provocação em área"

--------------------------------------------------------------------------------
-- Interrupts
--------------------------------------------------------------------------------

L["INTERRUPTS_SUMMARY"] = "Interrupções param um feitiço inimigo no meio do lançamento."
L["INTERRUPTS_ENABLE"] = "Ativar monitoramento de interrupções"

L["INTERRUPTS_ALERT_HEADER"] = "Interrupções bem-sucedidas"
L["INTERRUPTS_ALERT_DESC"] = "Um lançamento interrompido no meio. Diz quem interrompeu e o que foi interrompido."
L["INTERRUPTS_ALERT_ENABLE"] = "Avisar interrupções bem-sucedidas contra"
L["INTERRUPTS_ALERT_MINE"] = "Minhas interrupções bem-sucedidas"
L["INTERRUPTS_ALERT_OTHERS"] = "Interrupções bem-sucedidas dos outros"

--------------------------------------------------------------------------------
-- Fears
--------------------------------------------------------------------------------

L["FEARS_SUMMARY"] = "Medos fazem os inimigos sair correndo e espalham a puxada pela sala inteira."
L["FEARS_ENABLE"] = "Ativar monitoramento de medos"

L["FEARS_ALERT_HEADER"] = "Medos bem-sucedidos"
L["FEARS_ALERT_DESC"] =
	"Um medo que pegou e espalhou a puxada para fora do alcance do tanque. Só conta quando pega: um lançamento sem efeito, uma resistência e uma imunidade não tiraram ninguém do lugar, então nenhum deles é relatado."
L["FEARS_ALERT_ENABLE"] = "Avisar medos bem-sucedidos"
L["FEARS_ALERT_MINE"] = "Meus medos bem-sucedidos"
L["FEARS_ALERT_OTHERS"] = "Medos bem-sucedidos dos outros"

L["FEARS_ABILITIES_HEADER"] = "Habilidades de medo"

--------------------------------------------------------------------------------
-- Incapacitated
--------------------------------------------------------------------------------

L["INCAPACITATED_SUMMARY"] =
	"Avisa o seu grupo no momento em que você perde o controle do personagem, para que outra pessoa possa cobrir você. Um tanque amedrontado e um curador silenciado são as duas pessoas que mais precisam avisar, e as que menos conseguem fazer isso na hora."
L["INCAPACITATED_ENABLE"] = "Ativar monitoramento de incapacitação"

L["INCAPACITATED_HEADER"] = "Incapacitação"
L["INCAPACITATED_DESC"] =
	"Avisa o grupo quando você é atordoado, amedrontado, silenciado ou tirado da luta de qualquer outro jeito: o que pegou, quem lançou, quanto tempo dura e se alguém consegue remover."
--[[
    No trailing preposition and nothing beside it: this alert has no target
    ladder, and its "Long" threshold is a row of its own, above the two rows it
    names.
]]
L["INCAPACITATED_ALERT_ENABLE"] = "Avisar ao ser incapacitado"
--[[
    The only pair of rows in the add-on that is not My and Others'. The game
    reports the player's own losses of control and nobody else's, so "whose"
    has one answer; how LONG it lasts is the question with two.

    TRANSLATORS: keep the quotes around Long in the caption. They mark it as the
    word the two rows below are named after rather than as an adjective.
]]
L["INCAPACITATED_LONG_CAPTION"] = 'Mínimo para incapacitação "longa"'
L["INCAPACITATED_LONG_CAPTION_DESC"] =
	"Quanto tempo uma perda de controle precisa durar para contar como longa. Qualquer uma abaixo disso é curta. Nenhuma das duas é descartada. As duas linhas abaixo dizem para onde vai cada uma e, por padrão, apontam para lugares diferentes."
-- The caption's dropdown: the first reads for 1 only, the second for 2 to 10.
L["INCAPACITATED_THRESHOLD_ONE"] = "%d segundo"
L["INCAPACITATED_THRESHOLD"] = "%d segundos"
L["INCAPACITATED_SHORT"] = "Minha incapacitação curta"
L["INCAPACITATED_SHORT_DESC"] =
	"Para onde vai a linha quando você fica fora da luta por menos tempo que a duração acima. Por padrão, ela é exibida só na sua janela: um atordoamento do qual você volta antes que alguém pudesse cobrir você explica a recarga global que você acabou de perder, e não é problema de mais ninguém."
L["INCAPACITATED_LONG"] = "Minha incapacitação longa"
L["INCAPACITATED_LONG_DESC"] =
	"Para onde vai a linha quando você fica fora da luta por pelo menos a duração acima. Por padrão, ela é anunciada: é nessa que outra pessoa tem tempo de agir, e você é a única pessoa que não consegue avisar. Um efeito sem duração nenhuma, como um Controle Mental, conta como longo."

L["INCAPACITATED_STUN"] = "Incluir atordoamentos"
L["INCAPACITATED_STUN_DESC"] = "Perda total de controle, parado no lugar. Ficar adormecido conta como atordoamento."
L["INCAPACITATED_FEAR"] = "Incluir medos"
L["INCAPACITATED_FEAR_DESC"] =
	"Perda total de controle, correndo em direções aleatórias. O inimigo vai junto com você."
L["INCAPACITATED_CHARM"] = "Incluir controle mental"
L["INCAPACITATED_CHARM_DESC"] =
	"Totalmente sob o controle de outra pessoa. Geralmente a pior coisa desta lista, e geralmente por tempo indeterminado."
L["INCAPACITATED_CONFUSE"] = "Incluir confusão"
L["INCAPACITATED_CONFUSE_DESC"] = "Perda total de controle, andando em direções aleatórias."
L["INCAPACITATED_SILENCE"] = "Incluir silenciamentos"
L["INCAPACITATED_SILENCE_DESC"] =
	"Sem poder lançar feitiços. A provocação de um druida ou paladino é um feitiço, então essa é uma provocação que não vai sair."
L["INCAPACITATED_PACIFY"] = "Incluir pacificações"
L["INCAPACITATED_PACIFY_DESC"] = "Sem poder atacar, embora os feitiços ainda funcionem."
L["INCAPACITATED_SCHOOL_INTERRUPT"] = "Incluir bloqueios de feitiços"
L["INCAPACITATED_SCHOOL_INTERRUPT_DESC"] =
	"Sem poder lançar feitiços de uma escola. Vale a pena se você provoca com um feitiço, já que um druida ou paladino bloqueado em Natureza ou Sagrado fica sem provocação."
L["INCAPACITATED_ROOT"] = "Incluir enraizamentos"
L["INCAPACITATED_ROOT_DESC"] =
	"Sem poder se mover. Um tanque enraizado ainda tem o botão de provocar, então o inimigo não vai a lugar nenhum."
L["INCAPACITATED_DISARM"] = "Incluir desarmes"
L["INCAPACITATED_DISARM_DESC"] =
	"Sem poder atacar com armas. Assim como nos enraizamentos, o botão de provocar ainda funciona."

--------------------------------------------------------------------------------
-- Tank Deaths
--------------------------------------------------------------------------------

--[[
    One alert and one list: the tank going down is an alert section, with a row
    for your own death and one for every other tank's, and Deaths by Class is
    the log beside it.

    TRANSLATORS: the MINE and OTHERS rows name a death rather than a cast, which
    is why each carries a tooltip of its own. CLASS_ROW_DESC's %s is a class
    name, from the client.
]]
L["TANK_DEATHS_SUMMARY"] =
	"O tanque do seu grupo morreu. É a única morte que muda o que todos os outros devem fazer em seguida, e quarenta retratos de raide são o pior lugar para perceber isso."
L["TANK_DEATHS_ENABLE"] = "Ativar monitoramento de mortes de tanque"

L["TANK_DEATHS_ALERT_HEADER"] = "Mortes de tanque"
L["TANK_DEATHS_ALERT_DESC"] =
	"Conta o tanque principal do raide e qualquer um com a função de Tanque selecionada no localizador de grupos, incluindo você. São as duas únicas formas de o jogo dizer quem está tanqueando, então um tanque sem nenhuma das duas morre sem aviso."
L["TANK_DEATHS_ALERT_ENABLE"] = "Avisar mortes de tanque"
L["TANK_DEATHS_ALERT_MINE"] = "Minha morte"
L["TANK_DEATHS_ALERT_MINE_DESC"] =
	"Relata a sua própria morte enquanto você está tanqueando. O menu ao lado diz para onde vai a linha."
L["TANK_DEATHS_ALERT_OTHERS"] = "Mortes de tanque dos outros"
L["TANK_DEATHS_ALERT_OTHERS_DESC"] =
	"Relata a morte de qualquer outro do seu grupo que esteja tanqueando. O menu ao lado diz para onde vai a linha."

L["TANK_DEATHS_CLASS_HEADER"] = "Mortes por classe"
L["TANK_DEATHS_CLASS_DESC"] = "Todas as outras mortes, por classe, para as que você quiser acompanhar."
L["TANK_DEATHS_CLASS_ROW_DESC"] = "Avisa quando um %s do seu grupo morre."

--------------------------------------------------------------------------------
-- Bad Priests
--------------------------------------------------------------------------------

L["BAD_PRIESTS_SUMMARY"] =
	"Curadores fazendo algo que atrapalha o tanque mais do que ajuda. Só no Classic e no Burning Crusade: a Temporada da Descoberta devolve a raiva por meio de uma runa de sacerdote, e nada disso é problema nas versões mais recentes do jogo."
L["BAD_PRIESTS_ENABLE"] = "Ativar monitoramento de sacerdotes danados"

L["BAD_PRIESTS_HEADER"] = "Escudos ruins"
L["BAD_PRIESTS_DESC"] =
	"Avisa quando uma Palavra de Poder: Escudo cai em um druida ou guerreiro que está tanqueando. A raiva vem do dano recebido, e o dano que um escudo absorve não gera nenhuma, então um escudo bem-intencionado deixa o tanque sem a raiva que ele usa para segurar a ameaça."
L["BAD_PRIESTS_ALERT_ENABLE"] = "Avisar escudos ruins"
L["BAD_PRIESTS_HEALTH_DESC"] =
	'Quanto a vida do tanque precisa cair para um escudo deixar de ser um erro. Um escudo em alguém prestes a morrer é a escolha certa, então o aviso fica em silêncio abaixo do nível escolhido aqui. Escolha "Sempre" para saber de todos os escudos.'
L["BAD_PRIESTS_HEALTH_ALWAYS"] = "Sempre"
L["BAD_PRIESTS_HEALTH_EXCEPT"] = "Exceto vida abaixo de %d%%"
-- The one row: the report is about somebody else's cast, so it is not "My" anything.
L["BAD_PRIESTS_REPORT"] = "Avisos de escudo ruim"
L["BAD_PRIESTS_REPORT_DESC"] =
	"Para onde vai o aviso quando alguém lança escudo em um tanque que usa raiva. Aqui não há uma linha para você e outra para os outros: o lançamento é do curador e o problema é do tanque."
L["BAD_PRIESTS_SELF_ONLY"] = "Ao jogar de tanque druida ou guerreiro"
L["BAD_PRIESTS_SELF_ONLY_DESC"] =
	"Só avisa sobre escudos que caem em você, e só enquanto você for um druida ou guerreiro tanqueando. Desligue isto para saber de escudos em qualquer pessoa do seu grupo que esteja tanqueando com uma dessas classes."
L["BAD_PRIESTS_WHISPER"] = "Sussurrar a quem lançou"
L["BAD_PRIESTS_WHISPER_DESC"] =
	"Manda para quem lançou o escudo um recado explicando por que ele atrapalha. Só um sussurro é enviado, mesmo quando várias pessoas do seu grupo usam o Control Freak."
L["BAD_PRIESTS_COOLDOWN_DESC"] =
	"Quanto tempo quem lançou o escudo fica em silêncio depois de disparar um aviso de escudo. Vale para a exibição, o som, o anúncio e o sussurro, porque um curador que lança escudo toda vez que a recarga termina não pode encher a sua janela."

--------------------------------------------------------------------------------
-- Bad Pets
--------------------------------------------------------------------------------

-- Doubles as the mini-map button's Bad Pets line, so the two cannot differ.
L["BAD_PETS_SUMMARY"] =
	"Ajudantes de caçador e de bruxo com o lançamento automático ligado em habilidades de ameaça."
L["BAD_PETS_ENABLE"] = "Ativar monitoramento de ajudantes danados"

L["BAD_PETS_ALERT_HEADER"] = "Provocações de ajudante"
L["BAD_PETS_ALERT_DESC"] =
	"Um ajudante tirando o inimigo do tanque com o lançamento automático ligado, geralmente sem o dono perceber."
L["BAD_PETS_ALERT_ENABLE"] = "Avisar provocações de ajudante contra"
L["BAD_PETS_ALERT_MINE"] = "Provocações do meu ajudante"
L["BAD_PETS_ALERT_OTHERS"] = "Provocações de ajudante dos outros"
L["BAD_PETS_WHISPER_ENABLE"] = "Sussurrar ao dono do ajudante"
L["BAD_PETS_WHISPER_ENABLE_DESC"] =
	"Manda ao dono do ajudante um recado explicando como desligar o lançamento automático. Só um sussurro é enviado, mesmo quando várias pessoas do seu grupo usam o Control Freak."
L["BAD_PETS_COOLDOWN_DESC"] =
	"Quanto tempo um ajudante fica em silêncio depois de disparar um alerta. Vale para a exibição, o som, o anúncio e o sussurro, para que um ajudante com o lançamento automático ligado não encha a sua janela e o dono dele não receba outro sussurro a cada poucos segundos."

L["BAD_PETS_ABILITIES_HEADER"] = "Habilidades de ajudante danado"

--------------------------------------------------------------------------------
-- Tanking Tools
--------------------------------------------------------------------------------

--[[
    No summary line: the Tanking Tools tab opens on its enable, because the tab is
    a collection of unrelated warnings rather than one idea a sentence can cover.
    Each section introduces itself instead.
]]
L["TANKING_TOOLS_ENABLE"] = "Ativar arsenal do tanque"

L["TANKING_TOOLS_COLD_OPENER_HEADER"] = "Aberturas frias"
L["TANKING_TOOLS_COLD_OPENER_DESC"] =
	"Avisa sobre os seus próprios ataques de abertura que não pegaram: um erro, uma esquiva, um aparo, um bloqueio, uma resistência ou uma imunidade nos primeiros segundos de uma puxada. Ameaça que nunca aconteceu, bem na hora em que ela mais importa."
L["TANKING_TOOLS_COLD_OPENER_ENABLE"] = "Avisar aberturas frias contra"
L["TANKING_TOOLS_COLD_OPENER_MINE"] = "Minhas aberturas frias"
-- The caption before the window dropdown: "Within [10 Seconds of Fight]".
L["TANKING_TOOLS_COLD_OPENER_WITHIN"] = "Nos primeiros"
L["TANKING_TOOLS_COLD_OPENER_WINDOW"] = "%d segundos de luta"
L["TANKING_TOOLS_COLD_OPENER_WINDOW_DESC"] =
	"Até quanto tempo depois do início de uma puxada uma habilidade evitada ainda conta. O relógio começa na primeira vez que o Control Freak vê aquele inimigo, e só habilidades contam: um ataque automático erra vezes demais para virar notícia."

L["TANKING_TOOLS_ARMOR_HEADER"] = "Reduções de armadura"
L["TANKING_TOOLS_ARMOR_DESC"] =
	"Relata quanto tempo o grupo levou para reduzir a armadura de um alvo: cinco acúmulos de Fender Armadura ou um Expor Armadura de ladino. Marque uma das linhas Incluir abaixo e o relatório também espera por essa redução, mas só quando alguém do grupo pode de fato lançá-la."
L["TANKING_TOOLS_ARMOR_ENABLE"] = "Avisar reduções de armadura contra"
-- The one row: the report is the group's, so it is not "My" anything.
L["TANKING_TOOLS_ARMOR_REPORT"] = "Relatórios de redução de armadura"
L["TANKING_TOOLS_ARMOR_REPORT_DESC"] =
	"Para onde vai o relatório quando o grupo termina de reduzir a armadura de um alvo. Aqui não há uma linha para você e outra para os outros: o trabalho é do grupo, contado a você."
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE"] = "Incluir Fogo Feérico"
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE_DESC"] =
	"Espera por Fogo Feérico antes de relatar, seja qual for a versão que o druida lançar. Ignorado quando não há druida no grupo."
L["TANKING_TOOLS_ARMOR_RECKLESSNESS"] = "Incluir Maldição da Temeridade"
L["TANKING_TOOLS_ARMOR_RECKLESSNESS_DESC"] =
	"Espera por Maldição da Temeridade antes de relatar. Ignorado quando não há bruxo no grupo."

L["TANKING_TOOLS_PARRY_HEADER"] = "Aparos"
L["TANKING_TOOLS_PARRY_DESC"] =
	"Quem tem os ataques aparados por um inimigo que não está tanqueando está parado na frente dele. Cada aparo acelera o próximo golpe desse inimigo contra quem estiver tanqueando."
L["TANKING_TOOLS_PARRY_ENABLE"] = "Avisar aparos contra"
L["TANKING_TOOLS_PARRY_MINE"] = "Meus aparos"
L["TANKING_TOOLS_PARRY_OTHERS"] = "Aparos dos outros"
L["TANKING_TOOLS_PARRY_IGNORE_TANKS"] = "Ignorar outros tanques"
L["TANKING_TOOLS_PARRY_IGNORE_TANKS_DESC"] =
	"Fica em silêncio quando o jogador aparado é um tanque: o tanque principal do raide ou alguém com a função de Tanque. Um tanque secundário fica na frente do chefe para uma troca de provocação, e isso não é um erro para sussurrar. Os seus próprios aparos continuam sendo relatados."
L["TANKING_TOOLS_PARRY_WHISPER"] = "Sussurrar ao culpado"
L["TANKING_TOOLS_PARRY_WHISPER_DESC"] =
	"Manda ao culpado um recado pedindo para ficar atrás do inimigo. Só um sussurro é enviado, mesmo quando várias pessoas do seu grupo usam o Control Freak."
L["TANKING_TOOLS_PARRY_COOLDOWN_DESC"] =
	"Quanto tempo um culpado fica em silêncio depois de disparar um aviso de aparo. Vale para a exibição, o som, o anúncio e o sussurro, porque quem ainda não se mexeu não precisa ouvir isso a cada golpe."

L["TANKING_TOOLS_NOVA_HEADER"] = "Novas Congelantes"
L["TANKING_TOOLS_NOVA_DESC"] = "Avisa sobre uma Nova Congelante, que espalha a puxada para fora do alcance do tanque."
L["TANKING_TOOLS_NOVA_ENABLE"] = "Avisar Novas Congelantes"
L["TANKING_TOOLS_NOVA_MINE"] = "Minhas Novas Congelantes"
L["TANKING_TOOLS_NOVA_OTHERS"] = "Novas Congelantes dos outros"

--------------------------------------------------------------------------------
-- Message Formats
--------------------------------------------------------------------------------

--[[
    UNKNOWN_SOURCE opens a sentence ("Someone used..."). UNKNOWN_CASTER finishes
    one, after "from" in the INCAPACITATED lines below, whenever the game never
    named the mob that cast it.

    TRANSLATORS: word each for its own place in the sentence, including any case
    your "from" needs.
]]
L["UNKNOWN_SOURCE"] = "Alguém"
L["UNKNOWN_CASTER"] = "um lançador desconhecido"
L["UNKNOWN_TARGET"] = "um alvo desconhecido"
L["UNKNOWN_SPELL"] = "um feitiço desconhecido"

L["TAUNT_SUCCESS"] = "Provocação! %s usou %s em %s."
L["TAUNT_AOE"] = "Provocação em área! %s usou %s."
L["TAUNT_MISSED"] = "Provocação falhou! %s usou %s em %s e errou."
L["TAUNT_RESISTED"] = "Provocação falhou! %s usou %s em %s, que resistiu."
--[[
    The one failure format that leads with the MOB rather than the taunter,
    because the immunity is the news and the other three formats have no news
    beyond "it did not land".

    TRANSLATORS: %s is, in order: mob, taunter, taunt. This is the ONLY taunt
    format whose first %s is not the player who cast it.
]]
L["TAUNT_IMMUNE"] = "Provocação falhou! %s é imune: %s usou %s."
L["TAUNT_FAILED"] = "Provocação falhou! %s usou %s em %s sem efeito."
L["INTERRUPT"] = "Interrupção! %s usou %s em %s e interrompeu %s."

L["FEAR_SUCCESS"] = "Medo! %s usou %s em %s."
L["FEAR_AOE"] = "Medo em área! %s usou %s."

--[[
    Four formats for one line, because two clauses of it are optional and an
    empty pair of brackets reads worse than no brackets: the length, only when
    the effect has one (a Mind Control runs until somebody breaks it), and the
    (dispel type), only when the debuff has one a player could remove.

    TRANSLATORS: %s is, in order: role, [length,] player, spell, [dispel type,]
    caster. The role is INCAPACITATED_ROLE_TANK or _HEALER below, whichever seat
    the player is actually in, or the client's own class name for a player in
    neither seat. The length is a whole phrase from
    INCAPACITATED_SECOND / INCAPACITATED_SECONDS below, in whole seconds rounded
    up, and the two INDEFINITE formats have none. The two PLAIN formats have no
    dispel type.

    It names the player even though chat shows who sent it: several people in a
    raid may run Control Freak, and a bare "Incapacitated!" leaves the group
    working out who to cover for.
]]
L["INCAPACITATED"] = "%s incapacitado por %s; %s sofre %s (%s) de %s."
L["INCAPACITATED_PLAIN"] = "%s incapacitado por %s; %s sofre %s de %s."
L["INCAPACITATED_INDEFINITE"] = "%s incapacitado; %s sofre %s (%s) de %s."
L["INCAPACITATED_PLAIN_INDEFINITE"] = "%s incapacitado; %s sofre %s de %s."

--[[
    The seat the line opens on, as its own phrase rather than a format per role,
    which would be eight copies of the four above.

    TRANSLATORS: this is the client's own word for the group finder role, and it
    opens a sentence. "Afflicted by" in the formats above is deliberately the
    phrasing Blizzard's combat log uses for a debuff landing
    (AURAADDEDOTHERHARMFUL), so a player reads the same words here as in the log
    they already watch -- use your client's wording for both if it has one.
]]
L["INCAPACITATED_ROLE_TANK"] = "Tanque"
L["INCAPACITATED_ROLE_HEALER"] = "Curador"

--[[
    The length, as its own phrase rather than a bare number with "seconds" in the
    format, so the singular does not need two more formats beside the four
    above. Always a whole number: the handler rounds UP, because a fear reported
    as 5.9 promises a taunt back sooner than it is coming.

    TRANSLATORS: the handler reads exactly these two, the first for 1 and the
    second for every other count, so a language with more number forms words
    the second to read for any count. An abbreviated unit does.
]]
L["INCAPACITATED_SECOND"] = "%d segundo"
L["INCAPACITATED_SECONDS"] = "%d segundos"

--[[
    The four debuff types a player can take off. They name the class that can
    help -- Magic is a priest or paladin, Curse a mage or druid -- so they are
    the half of the line a tank cannot act on alone.

    TRANSLATORS: use the client's own words for these, the ones on the debuff
    tooltips, not a literal translation of the English.
]]
L["DISPEL_MAGIC"] = "Magia"
L["DISPEL_CURSE"] = "Maldição"
L["DISPEL_DISEASE"] = "Doença"
L["DISPEL_POISON"] = "Veneno"

--[[
    BOTH lines open on a bang, and the bang names the seat or the class that
    just went down: "Tank Down!" and "Mage Down!" read as one family, with the
    answer to "who died" in the first two words rather than in the middle of a
    sentence. What keeps the class rows quiet is that all nine ship OFF and
    none of them can play a sound, never a meeker wording.

    TRANSLATORS: %s in TANK_DEATHS_TANK_LINE is the dead player's name. In
    _CLASS_LINE it is the CLASS first and the name second. The class comes from
    the client rather than from this file, and it has to read as the subject of
    "Down!" in your language, so word the line around that order.
]]
L["TANK_DEATHS_TANK_LINE"] = "Tanque no chão! %s morreu."
L["TANK_DEATHS_CLASS_LINE"] = "%s no chão! %s morreu."

--[[
    Kept short on purpose: they render with a real spell link and two real names
    inside the 255 byte chat limit, and the widest locale runs close to twice the
    English.

    The WARNING carries no explanation and the WHISPER carries all of it. The
    warning fires mid-pull in front of a tank who already knows what a shield
    does; the whisper goes to the healer who does not, and is read after the
    fact. The tab description explains it at length for whoever wants it.
]]
L["SHIELD_WARNING"] = "Escudo ruim! %s lançou %s em %s."
L["SHIELD_WHISPER"] =
	"Escudo ruim! Por favor, evite lançar %s em %s. Essa habilidade impede os tanques de gerar raiva."

L["BAD_PET"] = "Ajudante danado! O ajudante de %s, %s, usou %s em %s."
L["BAD_PET_AOE"] = "Ajudante danado! O ajudante de %s, %s, usou %s."
L["BAD_PET_OWN"] = "Ajudante danado! O seu ajudante %s usou %s em %s."
L["BAD_PET_OWN_AOE"] = "Ajudante danado! O seu ajudante %s usou %s."
L["BAD_PET_UNKNOWN_OWNER"] = "Ajudante danado! %s usou %s em %s."
L["BAD_PET_UNKNOWN_OWNER_AOE"] = "Ajudante danado! %s usou %s."
--[[
    Kept short on purpose. It renders with a spell link and two names inside a 255
    byte chat limit, and the widest locale runs close to twice the English.
]]
L["BAD_PET_WHISPER"] =
	"O seu ajudante %s usou %s em %s. Clique com o botão direito nessa habilidade para desligar o lançamento automático."

L["COLD_OPENER_MISS"] = "Cuidado! %s usou %s e errou %s."
L["COLD_OPENER_DODGE"] = "Cuidado! %s usou %s e %s se esquivou."
L["COLD_OPENER_PARRY"] = "Cuidado! %s usou %s e %s aparou."
L["COLD_OPENER_BLOCK"] = "Cuidado! %s usou %s e %s bloqueou."
L["COLD_OPENER_IMMUNE"] = "Cuidado! %s usou %s e %s estava imune."
L["COLD_OPENER_RESIST"] = "Cuidado! %s usou %s e %s resistiu."

L["ARMOR_REPORT"] = "Armadura reduzida! %s fica vulnerável após %s s."

L["PARRY_WARNING"] = "Aceleração de aparo! %s está na frente de %s."
L["PARRY_WHISPER"] = "Aceleração de aparo! Por favor, fique atrás de %s: cada aparo acelera o próximo golpe dele."

L["NOVA"] = "Nova! %s usou %s em %s."
L["NOVA_AOE"] = "Nova em área! %s usou %s."
