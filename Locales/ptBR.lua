local L = LibStub("AceLocale-3.0"):NewLocale("ControlFreak", "ptBR")
if not L then
	return
end

--------------------------------------------------------------------------------
-- Identity
--------------------------------------------------------------------------------

L["ADDON_TITLE"] = "Control Freak"
L["ADDON_SHORT_NAME"] = "Control Freak"
L["OPTIONS_DESCRIPTION"] =
	"Anunciador de combate para provocações, interrupções, medos, mortes de tanque, ajudantes danados, aparos, reduções de armadura e outros eventos críticos da luta. Acompanhe quem provocou, o que falhou, quem interrompeu um lançamento e o que aconteceu, com alertas personalizáveis."

--------------------------------------------------------------------------------
-- Chat Messages
--------------------------------------------------------------------------------

L["CHAT_LOADED"] =
	"Versão %s. As configurações (incluindo a opção de desativar esta mensagem) estão em Opções > AddOns > Control Freak. Curtiu este add-on? Conta pra um amigo, marca como favorito no CurseForge ou dá uma estrela no GitHub. (="
L["CHAT_OPTIONS_IN_COMBAT"] = "Por segurança, a janela de opções não pode ser aberta durante o combate."

--------------------------------------------------------------------------------
-- General Panel
--------------------------------------------------------------------------------

L["ENABLE_WELCOME_MESSAGE"] = "Ativar mensagem de boas-vindas"
L["ENABLE_WELCOME_MESSAGE_DESC"] = "Mostra a saudação do Control Freak quando você entra no jogo."
L["ENABLE_MINIMAP_BUTTON"] = "Ativar botão do minimapa"
L["ENABLE_MINIMAP_BUTTON_DESC"] = "Mostra o botão do Control Freak no seu minimapa."

L["OPTIONS_MASTER_SWITCH_HEADER"] = "Chave geral"
L["OPTIONS_FEATURES_HEADER"] = "Recursos"
-- The Features block's group switches and their tooltip, whose %s is the group's own name, then each group's page summary. Its other switches read each tab's own name (TAB_*).
L["OPTIONS_MONITORING_LABEL"] = "Monitoramento"
L["OPTIONS_NAUGHTY_LIST_LABEL"] = "Lista dos danados"
L["OPTIONS_GROUP_ENABLE_DESC"] =
	"Desliga de uma vez tudo o que está em %s, ou liga de novo. Cada recurso mantém o seu próprio botão, então ligar este de novo traz de volta exatamente o que você tinha."
L["OPTIONS_MONITORING_SUMMARY"] =
	'O que aconteceu na luta: provocações, interrupções, medos, perder o controle do seu personagem, mortes do tanque e as recargas de um colega de classe. Desligar "Monitoramento" silencia os seis de uma vez, e cada um mantém o seu próprio botão.'
L["OPTIONS_NAUGHTY_LIST_SUMMARY"] =
	'Alguém do grupo dificultando o trabalho do tanque: a nova de um mago, alguém que não é tanque sendo aparado por um chefe, um ajudante com a provocação ligada, o escudo de um sacerdote num tanque de raiva. Desligar "Lista dos danados" silencia os quatro de uma vez, e cada um mantém o seu próprio botão.'

L["OPTIONS_COMMANDS_HEADER"] = "/Commands"
L["OPTIONS_COMMAND"] = "/freak"
L["OPTIONS_COMMAND_DESCRIPTION"] = "Abre a janela de opções deste add-on."

--[[
    The add-on's own switch. KILL_SWITCH names it in the status line a silenced
    page opens on, naming its REACH rather than the act of throwing it.
    KILL_SWITCH_ENABLE captions it under the General panel's Master Switch
    header, and KILL_SWITCH_ENABLE_DESC is that switch's tooltip.
]]
L["KILL_SWITCH"] = "Todos os alertas"
L["KILL_SWITCH_ENABLE"] = "Ativar Control Freak"
L["KILL_SWITCH_ENABLE_DESC"] = "Liga ou desliga todos os alertas do Control Freak."

--------------------------------------------------------------------------------
-- Feedback & Support Panel
--------------------------------------------------------------------------------

L["OPTIONS_LEVEL_UP_TITLE"] = "Ajude o Control Freak a subir de nível"
L["OPTIONS_LEVEL_UP_INTRO"] =
	"Este add-on foi criado por jogadores que amam este jogo e querem deixá-lo o mais divertido possível para todo mundo. Nunca vamos pedir doações. A verdadeira satisfação é saber que nosso trabalho deixa o jogo um pouco melhor para você. Se for o caso, adoraríamos saber!"
L["OPTIONS_LEVEL_UP_WAYS"] = "Aqui estão algumas formas de nos ajudar a alcançar mais jogadores."
L["OPTIONS_LEVEL_UP_FEEDBACK"] =
	"• Envie sua opinião: Encontrou um bug ou teve uma ideia? Avise a gente no Discord. Sua opinião nos ajuda a melhorar o add-on, e pull requests são sempre bem-vindos."
L["OPTIONS_LEVEL_UP_FRIEND"] =
	"• Conte para um amigo: Conhece alguém que pode curtir este add-on? Fale dele para essa pessoa. O boca a boca ajuda mais jogadores a descobrir ótimos add-ons."
L["OPTIONS_LEVEL_UP_CURSEFORGE"] =
	'• Favorite no CurseForge: Abra o link do CurseForge abaixo, entre na sua conta e clique na estrela sob o botão "Download". Os favoritos ajudam mais jogadores a descobrir o add-on.'
L["OPTIONS_LEVEL_UP_GITHUB"] =
	'• Estrela no GitHub: Abra o link do GitHub abaixo, entre na sua conta e clique em "Star" no canto superior direito. As estrelas ajudam o projeto a se qualificar para mais ferramentas gratuitas de desenvolvimento.'
L["OPTIONS_LEVEL_UP_THANKS"] = "Obrigado por escolher o Control Freak!"

L["OPTIONS_FEEDBACK"] = "Comentários e suporte"
L["OPTIONS_FEEDBACK_LINKS_HEADER"] = "Links de comentários e suporte"
L["OPTIONS_CURSEFORGE"] = "CurseForge"
L["OPTIONS_GITHUB"] = "GitHub"
L["OPTIONS_DISCORD"] = "Discord"
L["OPTIONS_WAGO"] = "Wago"
L["OPTIONS_COPY_LINK"] = "Para copiar um link, clique na caixa dele e pressione Ctrl+A e Ctrl+C."
L["OPTIONS_VERSION"] = "Versão %s"

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
L["MINIMAP_SHIFT_LEFT_CLICK"] = "Shift + clique esquerdo"
L["SHIFT_MIDDLE_CLICK"] = "Shift + clique do meio"
L["ACTION_TOGGLE"] = "Alternar"
L["MINIMAP_OPTIONS"] = "Opções do Control Freak"
--[[
    Each block's summary names everything its switch reaches, to show a player
    what there is to turn on. TRANSLATORS: keep each to two lines in the
    tooltip. TANKING_TOOLS_MINIMAP_SUMMARY, the third, sits with its tab below.
]]
L["MONITORING_MINIMAP_SUMMARY"] =
	"Provocações, interrupções, medos, incapacitação, mortes de tanque e pressão do grupo."
L["NAUGHTY_LIST_MINIMAP_SUMMARY"] =
	"Novas Congelantes, macacos de aparo, ajudantes com a provocação ligada e escudos em tanques de raiva."
-- Replaces the three blocks while All Alerts is off, since none of their clicks would do anything.
L["MINIMAP_ALL_ALERTS_OFF"] = '"Todos os alertas" está desligado, então nada dispara.'

--------------------------------------------------------------------------------
-- Feature Tabs
--------------------------------------------------------------------------------

-- In tab order.
L["TAB_TAUNTS"] = "Provocações"
L["TAB_INTERRUPTS"] = "Interrupções"
L["TAB_FEARS"] = "Medos"
L["TAB_INCAPACITATED"] = "Incapacitado"
L["TAB_TANK_DEATHS"] = "Mortes de tanque"
L["TAB_PEER_PRESSURE"] = "Pressão do grupo"
L["TAB_BAD_MAGES"] = "Magos danados"
L["TAB_BAD_PARRY_MONKEYS"] = "Macacos de aparo danados"
L["TAB_BAD_PETS"] = "Ajudantes danados"
L["TAB_BAD_PRIESTS"] = "Sacerdotes danados"
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
	'A função que você precisa ocupar para que este recurso diga alguma coisa. Você conta como tanque quando está designado como tanque principal em um raide, ou quando tem a função de Tanque selecionada no localizador de grupos em um grupo. Em um raide, a função de Tanque não vale nada. Você conta como curador apenas quando tem a função de Curador selecionada no localizador de grupos, já que não existe uma atribuição de raide para cura. "Sempre" deixa a pergunta de lado e dispara seja qual for a sua função.'
L["SCOPE_GROUP_HAS_TANK"] = "Quando o grupo tem tanque"
L["SCOPE_GROUP_HAS_TANK_DESC"] =
	"Só dispara enquanto alguém do seu grupo estiver tanqueando e ainda vivo. Em um raide, isso significa um tanque principal designado, então para o Control Freak um raide sem nenhum não tem tanque. Um tanque caído conta como se não houvesse tanque, porque é justamente aí que ajuda ter outra pessoa segurando a ameaça."
L["SCOPE_INSTANCE_ONLY"] = "Dentro de instâncias"
L["SCOPE_INSTANCE_ONLY_DESC"] = "Só dispara dentro de masmorras e raides."

--[[
    The line at the top of a page that a switch somewhere else has silenced:
    All Alerts on any feature page, the group a feature tab sits under, or the
    feature a sub-page belongs to. A group uses STATUS_FEATURE_OFF too.

    TRANSLATORS: in both, the first %s is the name of the switch that is off
    (drawn gold) and the second is STATUS_OFF (drawn red). The rest are plain
    names: in STATUS_ALL_ALERTS_OFF the switch's caption and then the page it
    is on, in STATUS_FEATURE_OFF the page it is on. STATUS_OFF is the single
    word for a switch being off.
]]
L["STATUS_OFF"] = "desativado"
L["STATUS_ALL_ALERTS_OFF"] = "%s: %s, então nada nesta página dispara. A chave, %s, fica na página %s."
L["STATUS_FEATURE_OFF"] = "%s: %s, então nada nesta página dispara. A chave fica na página %s."

--------------------------------------------------------------------------------
-- Alert Sections
--------------------------------------------------------------------------------

--[[
    Every alert on every tab is drawn as the same block, so each one owns five
    strings: a HEADER naming the thing that happened; an ENABLE reading "Enable
    Alerts for <that thing> On" -- the switch turns the telling on, not the
    event, and the target dropdown beside it finishes the sentence, so the
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
    The block every tab draws: whose cast is the row, beside it a Print box and
    an Announce dropdown, and the target filter is a ladder rather than a
    switch. Each section names its own two rows -- see
    TAUNTS_SUCCESS_MINE below -- because "My" and "Others'" agree with the noun
    in some languages and a shared "%s" template could not.

    TRANSLATORS: ALERT_AGAINST_DESC quotes one rung and one row by name; that
    wording must match your TARGET_RUNG_ELITE_0 and ALERT_MARKED_ALWAYS, or the
    tooltip explains a choice the player cannot find. ALERT_PRINT_DESC and
    ALERT_ANNOUNCE_DESC quote the Announce choices the same way. Keep
    ALERT_PRINT_HEADER short: it heads a narrow column of boxes. The four
    rungs are a threshold, widest first: each one counts itself and the ones
    after it, which is why every rung that includes bosses says so. Keep that
    in your translations -- a rung reading only "Elites" beside a separate
    "Bosses" reads as two disjoint sets.

    ALERT_MARKED_ALWAYS is the one control that WIDENS a section rather than
    narrowing it: a marked target counts whatever the rung says. Keep "Always"
    in it, and keep it distinct from the Announce choices -- this row decides
    WHETHER the alert fires, never where its line goes.
]]
L["ALERT_MINE_DESC"] = "As habilidades que você usa, incluindo as do seu ajudante."
L["ALERT_OTHERS_DESC"] = "As habilidades usadas por todos os outros do seu grupo."
-- The two column headers over a section's rows, then the Announce dropdown's three choices.
L["ALERT_PRINT_HEADER"] = "Exibir (só eu)"
L["ALERT_ANNOUNCE_HEADER"] = "Anunciar"
L["ALERT_ANNOUNCE_NEVER"] = "Nunca"
L["ALERT_ANNOUNCE_PARTY"] = "Em um grupo"
L["ALERT_ANNOUNCE_GROUP"] = "Em grupo ou raide"
L["ALERT_PRINT_DESC"] =
	'Marcada, a linha é exibida na sua própria janela sempre que não for anunciada: quando você está sozinho, quando "Anunciar" está em "Nunca", quando "Em um grupo" encontra um raide, ou dentro de um campo de batalha ou arena. Uma linha anunciada já aparece no seu bate-papo, então nunca é exibida duas vezes.'
L["ALERT_ANNOUNCE_DESC"] =
	'Quem mais vê a linha. "Em um grupo" manda a linha para o bate-papo do grupo num grupo de cinco ou menos, e fica quieto num raide. "Em grupo ou raide" manda a linha para o bate-papo do grupo ou do raide, conforme onde você estiver. Narrar o que os outros fazem para o raide inteiro é como um add-on deixa de ser bem-vindo, então vale pensar duas vezes nessa. Nada é anunciado quando você não está em grupo, nem dentro de campos de batalha e arenas.'
L["ALERT_AGAINST_DESC"] =
	'Quais inimigos contam; cada opção inclui as que vêm depois dela. Chefes são inimigos de nível caveira (??). Um chefe de masmorra não tem caveira própria, então conta como elite: "Elite do seu nível+ e chefes" é a opção que o mantém e deixa de fora os inimigos comuns de nível mais baixo ao redor dele. Uma marca de raide passa por cima de tudo isso enquanto a opção "Sempre avisar em alvos marcados" estiver ativada.'
L["TARGET_RUNG_ALL"] = "Tudo"
L["TARGET_RUNG_ELITE"] = "Elite e chefes"
L["TARGET_RUNG_ELITE_0"] = "Elite do seu nível+ e chefes"
L["TARGET_RUNG_BOSS"] = "Chefes"
L["ALERT_MARKED_ALWAYS"] = "Sempre avisar em alvos marcados"
L["ALERT_MARKED_ALWAYS_DESC"] =
	"Um alvo com marca de raide (caveira, xis, qualquer uma das oito) sempre conta, seja qual for a escolha no menu ao lado do interruptor da seção. Marcas são como o grupo aponta o que importa na puxada, então um alvo que alguém marcou nunca é descartado por não ter a categoria ou o nível certos."

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
    from the real message format below, so a reworded alert cannot leave a
    hand-copied example quoting the old text. The player's own name is the
    character they are on; SAMPLE_PLAYER stands in only until the client knows
    it. The other players' names are proper names in Data/Data.lua, the same in
    every locale. The pet's is translatable because it sits inside a sentence
    whose grammar a locale may want to agree with.
]]
L["SAMPLE_EXAMPLE"] = "Exemplo: %s"
L["SAMPLE_PLAYER"] = "Gogo"
L["SAMPLE_PET"] = "Bidu"

--[[
    The Molten Core and Blackwing Lair bosses the Example lines name, dealt one
    per line.

    TRANSLATORS: use each boss's name exactly as your client writes it, title
    included, not a translation of the English.
]]
L["SAMPLE_BOSS_LUCIFRON"] = "Lúcifron"
L["SAMPLE_BOSS_MAGMADAR"] = "Magmadar"
L["SAMPLE_BOSS_GEHENNAS"] = "Geena"
L["SAMPLE_BOSS_GARR"] = "Garr"
L["SAMPLE_BOSS_SHAZZRAH"] = "Shazzrah"
L["SAMPLE_BOSS_GEDDON"] = "Barão Geddon"
L["SAMPLE_BOSS_GOLEMAGG"] = "Golemagg, o Incinerador"
L["SAMPLE_BOSS_SULFURON"] = "Emissário de Sulfuron"
L["SAMPLE_BOSS_MAJORDOMO"] = "Senescal Executus"
L["SAMPLE_BOSS_RAGNAROS"] = "Ragnaros"
L["SAMPLE_BOSS_RAZORGORE"] = "Violâminus, o Indomado"
L["SAMPLE_BOSS_VAELASTRASZ"] = "Vaelastrasz, o Corrupto"
L["SAMPLE_BOSS_BROODLORD"] = "Prolemestre Flagelador"
L["SAMPLE_BOSS_FIREMAW"] = "Fogorja"
L["SAMPLE_BOSS_EBONROC"] = "Petrébano"
L["SAMPLE_BOSS_FLAMEGOR"] = "Flamagor"
L["SAMPLE_BOSS_CHROMAGGUS"] = "Cromaggus"
L["SAMPLE_BOSS_NEFARIAN"] = "Nefarian"

--------------------------------------------------------------------------------
-- Ability Lists
--------------------------------------------------------------------------------

L["TRACKED_HEADER"] = "Habilidades rastreadas"
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
L["TAUNTS_AOE_DESC"] =
	"Uma provocação que agarra tudo ao redor de uma vez, em vez de um alvo só. Todo lançamento é relatado, acerte o que acertar, mesmo quando o grupo não tem tanque."
L["TAUNTS_AOE_ENABLE"] = "Avisar provocações em área"
L["TAUNTS_AOE_MINE"] = "Minhas provocações em área"
L["TAUNTS_AOE_OTHERS"] = "Provocações em área dos outros"

L["TAUNTS_ABILITIES_DESC"] =
	'Desmarque uma provocação para deixar de rastreá-la. O menu suspenso ao lado escolhe entre "Alvo único" e "Área".'
-- The same intro on a client where no taunt's kind can be picked, so no row carries a dropdown.
L["TAUNTS_ABILITIES_DESC_NO_CHOICE"] = "Desmarque uma provocação para deixar de rastreá-la."
L["TAUNTS_KIND_SINGLE"] = "Alvo único"
L["TAUNTS_KIND_AOE"] = "Área"
L["TAUNTS_KIND_DESC"] =
	'Esta provocação agarra poucos inimigos de uma vez, então pode ser informada dos dois jeitos. A opção "Alvo único" nomeia cada inimigo puxado em "Provocações bem-sucedidas" e informa as falhas em "Provocações falhas". A opção "Área" informa só o lançamento, em "Provocações em área", e deixa as falhas de fora.'

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
	"Um medo que espalha a puxada para fora do alcance do tanque. Um medo em área é relatado a cada lançamento, acerte o que acertar. Um medo de alvo único só é relatado quando pega, já que uma resistência ou uma imunidade não moveu nada."
L["FEARS_ALERT_ENABLE"] = "Avisar medos bem-sucedidos"
L["FEARS_ALERT_MINE"] = "Meus medos bem-sucedidos"
L["FEARS_ALERT_OTHERS"] = "Medos bem-sucedidos dos outros"

L["FEARS_ABILITIES_DESC"] = "Desmarque um medo para deixar de rastreá-lo."

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
	"Fora da luta por menos tempo que a duração acima. Por padrão, isso é exibido só na sua própria janela: um atordoamento do qual você volta antes que alguém pudesse cobrir você explica a recarga global que você acabou de perder, e não é problema de mais ninguém."
L["INCAPACITATED_LONG"] = "Minha incapacitação longa"
L["INCAPACITATED_LONG_DESC"] =
	"Fora da luta por pelo menos a duração acima. Por padrão, isso é anunciado em grupo e exibido em raide: é nesse caso que outra pessoa tem tempo de agir, e você é a única pessoa que não consegue avisar. Um efeito sem duração nenhuma, como um Controle Mental, conta como longo."

L["INCAPACITATED_EFFECTS_HEADER"] = "Efeitos incluídos"
L["INCAPACITATED_EFFECTS_DESC"] = "Desmarque um efeito para deixar de avisar sobre ele."

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
	"Saiba na hora quando um tanque do seu grupo morre. É a única morte que muda o que todos os outros devem fazer em seguida, e quarenta retratos de raide são o pior lugar para perceber isso."
L["TANK_DEATHS_ENABLE"] = "Ativar monitoramento de mortes de tanque"

L["TANK_DEATHS_ALERT_HEADER"] = "Mortes de tanque"
L["TANK_DEATHS_ALERT_DESC"] =
	"Em um raide, conta apenas os jogadores designados como tanque principal, incluindo você, e uma função do localizador de grupos não vale nada ali. Em um grupo, conta qualquer um com a função de Tanque selecionada no localizador de grupos. Um tanque sem nenhuma das duas morre sem aviso."
L["TANK_DEATHS_ALERT_ENABLE"] = "Avisar mortes de tanque"
L["TANK_DEATHS_ALERT_MINE"] = "Minha morte"
L["TANK_DEATHS_ALERT_MINE_DESC"] = "A sua própria morte enquanto você está tanqueando."
L["TANK_DEATHS_ALERT_OTHERS"] = "Mortes de tanque dos outros"
L["TANK_DEATHS_ALERT_OTHERS_DESC"] = "A morte de qualquer outro do seu grupo que esteja tanqueando."

L["TANK_DEATHS_CLASS_HEADER"] = "Mortes por classe"
L["TANK_DEATHS_CLASS_DESC"] = "Todas as outras mortes, por classe, para as que você quiser acompanhar."
L["TANK_DEATHS_CLASS_ROW_DESC"] = "Avisa quando um %s do seu grupo morre."

--------------------------------------------------------------------------------
-- Peer Pressure
--------------------------------------------------------------------------------

--[[
    The alert is the whose shape with no target, like Fears: the line names a
    classmate and a cooldown.

    TRANSLATORS: the two rows' tooltips each say what they count, because
    neither is "everybody's casts": only the player's own class ever reports,
    and the My row has no pet to include.
]]
L["PEER_PRESSURE_SUMMARY"] =
	"Receba um aviso quando outros jogadores da sua classe usarem suas habilidades com recarga, para você ceder à pressão do grupo."
L["PEER_PRESSURE_ENABLE"] = "Ativar pressão do grupo"

L["PEER_PRESSURE_ALERT_HEADER"] = "Recargas"
L["PEER_PRESSURE_ALERT_DESC"] =
	"Uma habilidade com recarga usada por um jogador da sua classe no seu grupo: o sinal para usar a sua. Só a sua própria classe é relatada, e Habilidades rastreadas escolhe quais contam."
L["PEER_PRESSURE_ALERT_ENABLE"] = "Avisar recargas"
L["PEER_PRESSURE_ALERT_MINE"] = "Minhas recargas"
L["PEER_PRESSURE_ALERT_MINE_DESC"] = "As suas próprias habilidades com recarga rastreadas."
L["PEER_PRESSURE_ALERT_OTHERS"] = "Recargas dos outros"
L["PEER_PRESSURE_ALERT_OTHERS_DESC"] =
	"Uma habilidade com recarga rastreada usada por qualquer outro jogador da sua classe no seu grupo."

L["PEER_PRESSURE_ABILITIES_DESC"] =
	"Desmarque uma habilidade com recarga para deixar de rastreá-la. Só as da sua própria classe são relatadas."

--------------------------------------------------------------------------------
-- Bad Mages
--------------------------------------------------------------------------------

L["BAD_MAGES_SUMMARY"] = "Magos fazendo algo que prende a puxada fora do alcance do tanque."
L["BAD_MAGES_ENABLE"] = "Ativar monitoramento de magos danados"

L["BAD_MAGES_ALERT_HEADER"] = "Novas"
L["BAD_MAGES_ALERT_DESC"] =
	"Avisa sobre uma Nova Congelante, que congela a puxada onde ela está, fora do alcance do tanque."
L["BAD_MAGES_ALERT_ENABLE"] = "Avisar novas"
L["BAD_MAGES_ALERT_MINE"] = "Minhas novas"
L["BAD_MAGES_ALERT_OTHERS"] = "Novas dos outros"
L["BAD_MAGES_WHISPER_ENABLE"] = "Sussurrar ao mago"
L["BAD_MAGES_WHISPER_ENABLE_DESC"] =
	"Manda ao mago um recado pedindo para guardar a Nova Congelante para emergências. Só um sussurro é enviado, mesmo quando várias pessoas do seu grupo usam o Control Freak."
L["BAD_MAGES_COOLDOWN_DESC"] =
	"Quanto tempo um mago fica em silêncio depois de disparar um alerta de nova. Vale para a exibição, o som, o anúncio e o sussurro, para que um mago que solta nova em toda puxada não encha a sua janela."

--------------------------------------------------------------------------------
-- Bad Parry Monkeys
--------------------------------------------------------------------------------

L["BAD_PARRY_MONKEYS_SUMMARY"] =
	"Jogadores que não estão tanqueando, parados na frente de um chefe e sendo aparados. Cada aparo acelera o próximo golpe do chefe contra o tanque."
L["BAD_PARRY_MONKEYS_ENABLE"] = "Ativar monitoramento de macacos de aparo"

L["BAD_PARRY_MONKEYS_ALERT_HEADER"] = "Aparos"
L["BAD_PARRY_MONKEYS_ALERT_DESC"] =
	"Quem tem os ataques aparados por um inimigo sem ser o tanque dele está parado na frente dele. Cada aparo acelera o próximo golpe desse inimigo contra quem estiver tanqueando."
L["BAD_PARRY_MONKEYS_ALERT_ENABLE"] = "Avisar aparos contra"
L["BAD_PARRY_MONKEYS_ALERT_MINE"] = "Meus aparos"
L["BAD_PARRY_MONKEYS_ALERT_MINE_DESC"] = "Um inimigo aparando os seus ataques."
L["BAD_PARRY_MONKEYS_ALERT_OTHERS"] = "Aparos dos outros"
L["BAD_PARRY_MONKEYS_ALERT_OTHERS_DESC"] = "Um inimigo aparando os ataques de qualquer outro do seu grupo."
L["BAD_PARRY_MONKEYS_IGNORE_TANKS"] = "Ignorar tanques"
L["BAD_PARRY_MONKEYS_IGNORE_TANKS_DESC"] =
	"Fica em silêncio quando o jogador que teve o ataque aparado é um tanque: designado como tanque principal em um raide, ou com a função de Tanque selecionada no localizador de grupos em um grupo. Um tanque secundário fica na frente do chefe para uma troca de provocação, e isso não é um erro para sussurrar. Os seus próprios aparos continuam sendo relatados."
L["BAD_PARRY_MONKEYS_IGNORE_PETS"] = "Ignorar ajudantes"
L["BAD_PARRY_MONKEYS_IGNORE_PETS_DESC"] =
	"Fica em silêncio quando quem foi aparado é um ajudante, o seu incluído. Um ajudante fica onde o dono o mandou, e uma linha com o nome do ajudante não dá nada a fazer a ninguém do grupo. Ajudantes nunca recebem sussurro, de qualquer forma."
L["BAD_PARRY_MONKEYS_WHISPER"] = "Sussurrar ao culpado"
L["BAD_PARRY_MONKEYS_WHISPER_DESC"] =
	"Manda ao culpado um recado pedindo para ficar atrás do inimigo. Só um sussurro é enviado, mesmo quando várias pessoas do seu grupo usam o Control Freak."
L["BAD_PARRY_MONKEYS_COOLDOWN_DESC"] =
	"Quanto tempo um culpado fica em silêncio depois de disparar um aviso de aparo. Vale para a exibição, o som, o anúncio e o sussurro, porque quem ainda não se mexeu não precisa ouvir isso a cada golpe."

--[[
    Parry Monkey, the section under Parries: the player owning up to their own
    parries, with a running count, every so often. TRANSLATORS: the message is
    the player's own words, so its default is a line a player would say about
    themselves.
]]
L["BAD_PARRY_MONKEYS_MONKEY_HEADER"] = "Macaco de aparo"
L["BAD_PARRY_MONKEYS_MONKEY_DESC"] =
	"Confesse quando um chefe de raide que você não está tanqueando aparar você, com a contagem de todos os aparos desde que você entrou no grupo de raide. Todo aparo conta, e a recarga abaixo decide com que frequência você fala."
L["BAD_PARRY_MONKEYS_MONKEY_ENABLE"] = "Avisar macaco de aparo"
L["BAD_PARRY_MONKEYS_MONKEY_MINE"] = "Minhas confissões"
L["BAD_PARRY_MONKEYS_MONKEY_MINE_DESC"] = "Os seus próprios aparos, com as suas próprias palavras."
L["BAD_PARRY_MONKEYS_MONKEY_MESSAGE"] = "Mensagem"
L["BAD_PARRY_MONKEYS_MONKEY_MESSAGE_DESC"] =
	"O que a sua confissão diz. A contagem vem depois e volta a zero sempre que você entra em um grupo de raide."
L["BAD_PARRY_MONKEYS_MONKEY_MESSAGE_DEFAULT"] = "Eu sou um macaco de aparo danado!"
L["BAD_PARRY_MONKEYS_MONKEY_COOLDOWN"] = "Recarga"
L["BAD_PARRY_MONKEYS_MONKEY_COOLDOWN_DESC"] =
	"Quanto tempo você fica quieto depois de uma confissão. Os aparos no meio-tempo continuam contando, então a próxima leva a contagem inteira."

--------------------------------------------------------------------------------
-- Bad Pets
--------------------------------------------------------------------------------

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

L["BAD_PETS_ABILITIES_DESC"] = "Desmarque uma habilidade de ajudante para deixar de rastreá-la."

--------------------------------------------------------------------------------
-- Bad Priests
--------------------------------------------------------------------------------

L["BAD_PRIESTS_SUMMARY"] = "Curadores fazendo algo que atrapalha o tanque mais do que ajuda."
-- Shown only on a client whose data has no Power Word: Shield row, which among the shipped ones is Season of Discovery's.
L["BAD_PRIESTS_DISCOVERY_STATUS"] =
	"A Temporada da Descoberta nunca relata um escudo ruim: a runa Força da Alma devolve a raiva aos tanques, e nenhum add-on consegue ver as runas de outro jogador."
L["BAD_PRIESTS_ENABLE"] = "Ativar monitoramento de sacerdotes danados"

L["BAD_PRIESTS_HEADER"] = "Escudos ruins"
L["BAD_PRIESTS_DESC"] =
	"Avisa quando uma Palavra de Poder: Escudo cai em um druida ou guerreiro que está tanqueando. A raiva vem do dano recebido, e o dano que um escudo absorve não gera nenhuma, então um escudo bem-intencionado deixa o tanque sem a raiva que ele usa para segurar a ameaça. Um escudo antes da puxada, num tanque que ainda não está em combate, é deixado de lado."
L["BAD_PRIESTS_ALERT_ENABLE"] = "Avisar escudos ruins"
L["BAD_PRIESTS_HEALTH_DESC"] =
	'Quanto a vida do tanque precisa cair para um escudo deixar de ser um erro. Um escudo em alguém prestes a morrer é a escolha certa, então o aviso fica em silêncio abaixo do nível escolhido aqui. Escolha "Sempre" para saber de todos os escudos.'
L["BAD_PRIESTS_HEALTH_ALWAYS"] = "Sempre"
L["BAD_PRIESTS_HEALTH_EXCEPT"] = "Exceto vida abaixo de %d%%"
-- The one row: the report is about somebody else's cast, so it is not "My" anything.
L["BAD_PRIESTS_REPORT"] = "Avisos de escudo ruim"
L["BAD_PRIESTS_REPORT_DESC"] =
	"Alguém lançando escudo em um tanque que usa raiva. Aqui não há uma linha para você e outra para os outros: o lançamento é do curador e o problema é do tanque."
L["BAD_PRIESTS_SELF_ONLY"] = "Ao jogar de tanque druida ou guerreiro"
L["BAD_PRIESTS_SELF_ONLY_DESC"] =
	"Só avisa sobre escudos que caem em você, e só enquanto você for um druida ou guerreiro tanqueando. Desligue isto para saber de escudos em qualquer pessoa do seu grupo que esteja tanqueando com uma dessas classes."
L["BAD_PRIESTS_WHISPER"] = "Sussurrar a quem lançou"
L["BAD_PRIESTS_WHISPER_DESC"] =
	"Manda para quem lançou o escudo um recado explicando por que ele atrapalha. Só um sussurro é enviado, mesmo quando várias pessoas do seu grupo usam o Control Freak."
L["BAD_PRIESTS_COOLDOWN_DESC"] =
	"Quanto tempo quem lançou o escudo fica em silêncio depois de disparar um aviso de escudo. Vale para a exibição, o som, o anúncio e o sussurro, porque um curador que lança escudo toda vez que a recarga termina não pode encher a sua janela."

--------------------------------------------------------------------------------
-- Tanking Tools
--------------------------------------------------------------------------------

--[[
    The tab's summary says it ships off and where its two tools live, since
    each tool is a page of its own and the tab page holds only the switch.

    The mini-map tooltip carries its own shorter one, because the button's
    Shift + Left-Click toggles this tab and the tooltip has to say what it is
    turning on. TRANSLATORS: it lists the two section headers below in your
    own words for them; keep it to two lines in the tooltip.
]]
L["TANKING_TOOLS_SUMMARY"] =
	"Este recurso ainda está em beta, por isso vem desligado. Aberturas frias e Reduções de armadura têm cada uma a sua própria página dentro de Arsenal do tanque."
L["TANKING_TOOLS_ENABLE"] = "Ativar arsenal do tanque"
L["TANKING_TOOLS_MINIMAP_SUMMARY"] = "Aberturas frias e reduções de armadura."

L["TANKING_TOOLS_COLD_OPENER_HEADER"] = "Aberturas frias"
L["TANKING_TOOLS_COLD_OPENER_DESC"] =
	"Avisa sobre os seus próprios ataques de abertura que não pegaram: um erro, uma esquiva, um aparo, um bloqueio, uma resistência ou uma imunidade nos primeiros segundos de uma puxada. Ameaça que nunca aconteceu, bem na hora em que ela mais importa."
L["TANKING_TOOLS_COLD_OPENER_ENABLE"] = "Avisar aberturas frias contra"
L["TANKING_TOOLS_COLD_OPENER_MINE"] = "Minhas aberturas frias"
L["TANKING_TOOLS_COLD_OPENER_MINE_DESC"] = "As suas próprias habilidades de abertura que não pegaram."
-- The caption before the window dropdown: "Within [10 Seconds of the Pull]".
L["TANKING_TOOLS_COLD_OPENER_WITHIN"] = "Nos primeiros"
L["TANKING_TOOLS_COLD_OPENER_WINDOW"] = "%d segundos da puxada"
L["TANKING_TOOLS_COLD_OPENER_WINDOW_DESC"] =
	"Até quanto tempo depois do início de uma puxada uma habilidade evitada ainda conta. O relógio começa na primeira vez que o Control Freak vê aquele inimigo, e só habilidades contam: um ataque automático erra vezes demais para virar notícia."

L["TANKING_TOOLS_ARMOR_HEADER"] = "Reduções de armadura"
L["TANKING_TOOLS_ARMOR_DESC"] =
	"Relata quanto tempo o grupo levou para reduzir a armadura de um alvo: cinco acúmulos de Fender Armadura ou um Expor Armadura de ladino. Marque uma das linhas Incluir abaixo e o relatório também espera por essa redução, mas só quando alguém do grupo pode de fato lançá-la."
L["TANKING_TOOLS_ARMOR_ENABLE"] = "Avisar reduções de armadura contra"
-- The one row: the report is the group's, so it is not "My" anything.
L["TANKING_TOOLS_ARMOR_REPORT"] = "Relatórios de redução de armadura"
L["TANKING_TOOLS_ARMOR_REPORT_DESC"] =
	"O grupo reduzindo a armadura de um alvo. Aqui não há uma linha para você e outra para os outros: o trabalho é do grupo, contado a você."
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE"] = "Incluir Fogo Feérico"
L["TANKING_TOOLS_ARMOR_FAERIE_FIRE_DESC"] =
	"Espera por Fogo Feérico antes de relatar, seja qual for a versão que o druida lançar. Ignorado quando não há druida no grupo."
L["TANKING_TOOLS_ARMOR_RECKLESSNESS"] = "Incluir Maldição da Temeridade"
L["TANKING_TOOLS_ARMOR_RECKLESSNESS_DESC"] =
	"Espera por Maldição da Temeridade antes de relatar. Ignorado quando não há bruxo no grupo."

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
L["TAUNT_FAILED"] = "Provocação falhou! %s usou %s em %s e não surtiu efeito."
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
L["INCAPACITATED"] = "%s incapacitado por %s! %s sofre %s (%s) de %s."
L["INCAPACITATED_PLAIN"] = "%s incapacitado por %s! %s sofre %s de %s."
L["INCAPACITATED_INDEFINITE"] = "%s incapacitado! %s sofre %s (%s) de %s."
L["INCAPACITATED_PLAIN_INDEFINITE"] = "%s incapacitado! %s sofre %s de %s."

--[[
    The seat the line opens on, as its own phrase rather than a format per role,
    which would be eight copies of the four above.

    TRANSLATORS: this is our own word for the person in that seat, not the
    client's group finder role label, which names a role rather than a person.
    It opens a sentence as its subject. "Afflicted by" in the formats above is
    deliberately the phrasing Blizzard's combat log uses for a debuff landing
    (AURAADDEDOTHERHARMFUL), so a player reads the same words here as in the
    log they already watch -- use your client's wording for both if it has one.
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
	"Sacerdote danado! Por favor, evite lançar %s em %s. Essa habilidade impede os tanques de gerar raiva."

L["BAD_PET"] = "Ajudante danado! O ajudante de %s, %s, usou %s em %s."
L["BAD_PET_AOE"] = "Ajudante danado! O ajudante de %s, %s, usou %s."
L["BAD_PET_UNKNOWN_OWNER"] = "Ajudante danado! %s usou %s em %s."
L["BAD_PET_UNKNOWN_OWNER_AOE"] = "Ajudante danado! %s usou %s."
--[[
    Kept short on purpose. They render with a spell link and up to two names
    inside a 255 byte chat limit, and the widest locale runs close to twice the
    English.
]]
L["BAD_PET_WHISPER"] =
	"Ajudante danado! O seu ajudante %s usou %s em %s. Clique com o botão direito nessa habilidade para desligar o lançamento automático."
L["BAD_PET_WHISPER_AOE"] =
	"Ajudante danado! O seu ajudante %s usou %s. Clique com o botão direito nessa habilidade para desligar o lançamento automático."

L["COLD_OPENER_MISS"] = "Cuidado! %s usou %s e errou %s."
L["COLD_OPENER_DODGE"] = "Cuidado! %s usou %s e %s se esquivou."
L["COLD_OPENER_PARRY"] = "Cuidado! %s usou %s e %s aparou."
L["COLD_OPENER_BLOCK"] = "Cuidado! %s usou %s e %s bloqueou."
L["COLD_OPENER_IMMUNE"] = "Cuidado! %s usou %s e %s estava imune."
L["COLD_OPENER_RESIST"] = "Cuidado! %s usou %s e %s resistiu."

L["ARMOR_REPORT"] = "Armadura reduzida! %s ficou vulnerável após %s s."

L["PARRY_WARNING"] = "Aceleração de aparo! %s está na frente de %s."
L["PARRY_WHISPER"] =
	"Macaco de aparo danado! Por favor, fique atrás de %s; cada aparo faz o chefe atacar mais rápido e o tanque levar mais dano."
-- Parry Monkey's line. TRANSLATORS: %s is the player's own message, %d the count since joining the raid group.
L["PARRY_CONFESSION"] = "%s (x%d)"

L["NOVA"] = "Nova! %s usou %s em %s."
L["NOVA_AOE"] = "Nova em área! %s usou %s."
--[[
    Every whisper opens on "Naughty" and the culprit it is addressed to, the
    Naughty List's own word, where the line the group sees opens on the news.
    TRANSLATORS: %s is the spell.
]]
L["NOVA_WHISPER"] =
	"Mago danado! A sua %s congelou a puxada fora do alcance do tanque. Por favor, guarde-a para emergências."

--[[
    Opens on a bang naming the news, like every other alert line.

    TRANSLATORS: %s in PEER_PRESSURE_TARGET is, in order: caster, spell, and
    the friendly player it was cast on. The target is a player, never a mob.
]]
L["PEER_PRESSURE"] = "Pressão do grupo! %s usou %s."
L["PEER_PRESSURE_TARGET"] = "Pressão do grupo! %s usou %s em %s."
