export const logout = 'sair'
export const unsupported = 'este navegador não suporta WebRTC'
export const admin_loggedin = 'Você está logado como administrador'
export const you = 'Você'
export const somebody = 'Alguém'
export const send_a_message = 'Enviar uma mensagem'

export const side = {
  chat: 'Chat',
  files: 'Arquivos',
  settings: 'Configurações',
}

export const connect = {
  login_title: 'Por favor, faça login',
  invitation_title: 'Você foi convidado para esta sala',
  displayname: 'Digite seu nome de exibição',
  password: 'Senha',
  connect: 'Conectar',
  error: 'Erro de login',
  empty_displayname: 'O nome de exibição não pode estar vazio.',
}

export const context = {
  ignore: 'Ignorar',
  unignore: 'Parar de ignorar',
  mute: 'Silenciar',
  unmute: 'Desmutar',
  release: 'Forçar liberação dos controles',
  take: 'Forçar tomada dos controles',
  give: 'Dar controles',
  kick: 'Expulsar',
  ban: 'Banir IP',
  confirm: {
    kick_title: 'Expulsar {name}?',
    kick_text: 'Você tem certeza que deseja expulsar {name}?',
    ban_title: 'Banir {name}?',
    ban_text: 'Deseja banir {name}? Você precisará reiniciar o servidor para desfazer isso.',
    mute_title: 'Silenciar {name}?',
    mute_text: 'Você tem certeza que deseja silenciar {name}?',
    unmute_title: 'Desmutar {name}?',
    unmute_text: 'Deseja desmutar {name}?',
    button_yes: 'Sim',
    button_cancel: 'Cancelar',
  },
}

export const controls = {
  release: 'Liberar controles',
  request: 'Solicitar controles',
  lock: 'Bloquear controles',
  unlock: 'Desbloquear controles',
  has: 'Você tem o controle',
  hasnot: 'Você não tem o controle',
  mic_on: 'Ativar microfone',
  mic_off: 'Desativar microfone',
  mic_error: 'Erro no microfone',
}

export const locks = {
  control: {
    lock: 'Bloquear controles (para usuários)',
    unlock: 'Desbloquear controles (para usuários)',
    locked: 'Controles bloqueados (para usuários)',
    unlocked: 'Controles desbloqueados (para usuários)',
    notif_locked: 'controles bloqueados para usuários',
    notif_unlocked: 'controles desbloqueados para usuários',
  },
  login: {
    lock: 'Bloquear sala (para usuários)',
    unlock: 'Desbloquear sala (para usuários)',
    locked: 'Sala bloqueada (para usuários)',
    unlocked: 'Sala desbloqueada (para usuários)',
    notif_locked: 'sala bloqueada',
    notif_unlocked: 'sala desbloqueada',
  },
  file_transfer: {
    lock: 'Bloquear transferência de arquivos (para usuários)',
    unlock: 'Desbloquear transferência de arquivos (para usuários)',
    locked: 'Transferência de arquivos bloqueada (para usuários)',
    unlocked: 'Transferência de arquivos desbloqueada (para usuários)',
    notif_locked: 'transferência de arquivos bloqueada',
    notif_unlocked: 'transferência de arquivos desbloqueada',
  },
}

export const setting = {
  scroll: 'Sensibilidade do scroll',
  scroll_invert: 'Inverter scroll',
  autoplay: 'Reprodução automática',
  ignore_emotes: 'Ignorar emotes',
  chat_sound: 'Som do chat',
  keyboard_layout: 'Layout do teclado',
}

export const connection = {
  logged_out: 'Você foi desconectado.',
  reconnecting: 'Reconectando...',
  connected: 'Conectado',
  disconnected: 'Desconectado',
  kicked: 'Você foi removido desta sala.',
  button_confirm: 'OK',
}

export const notifications = {
  connected: '{name} entrou',
  disconnected: '{name} saiu',
  controls_taken: '{name} assumiu os controles',
  controls_taken_force: 'assumiu os controles forçadamente',
  controls_taken_steal: 'tomou os controles de {name}',
  controls_released: '{name} liberou os controles',
  controls_released_force: 'liberou os controles forçadamente',
  controls_released_steal: 'liberou os controles de {name}',
  controls_given: 'deu os controles para {name}',
  controls_has: '{name} tem os controles',
  controls_has_alt: 'Mas eu avisei a pessoa que você queria',
  controls_requesting: '{name} está solicitando os controles',
  resolution: 'alterou a resolução para {width}x{height}@{rate}',
  banned: 'baniu {name}',
  kicked: 'expulsou {name}',
  muted: 'silenciou {name}',
  unmuted: 'desmutou {name}',
}

export const files = {
  downloads: 'Downloads',
  uploads: 'Uploads',
  upload_here: 'Clique ou arraste arquivos aqui para enviar',
}
