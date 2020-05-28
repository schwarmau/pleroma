use Mix.Config

config :logger, level: :info

config :tesla, adapter: Tesla.Adapter.Hackney
config :pleroma, :hackney_pools,
  federation: [
    max_connections: 50,
    timeout: 150_000
  ],
  media: [
    max_connections: 50,
    timeout: 150_000
  ],
  upload: [
    max_connections: 25,
    timeout: 300_000
  ]

config :pleroma, Pleroma.Repo,
    adapter: Ecto.Adapters.Postgres,
    username: "pleroma",
    password: "pleroma",
    database: "pleroma",
    hostname: "db",
    pool_size: 16

config :pleroma, Pleroma.Web.Endpoint,
    url: [host: "cyborg.cafe", scheme: "https", port: 443],
    http: [
      ip: {0, 0, 0, 0},
      port: 4000
    ]

config :pleroma, :http_security,
    enabled: false

config :pleroma, :gopher,
    enabled: true,
    ip: {0, 0, 0, 0},
    port: 9999

config :esshd,
    enabled: true,
    port: 2222

config :pleroma, :media_proxy,
    enabled: true,
    proxy_opts: [
        redirect_on_failure: true
    ]

config :pleroma, Pleroma.Uploaders.Local, uploads: "/uploads"

config :pleroma, Pleroma.Upload,
    filters: [Pleroma.Upload.Filter.Dedupe, Pleroma.Upload.Filter.Mogrify]

config :pleroma, Pleroma.Upload.Filter.Mogrify,
    args: ["strip"]

config :pleroma, :chat, enabled: false
config :pleroma, :rich_media, enabled: true

config :pleroma, :instance,
    name: "Cyborg Cafe",
    description: "Have a coffee and recharge your batteries.",
    email: "gilgamoosh32@gmail.com",
    limit: 16384,
    remote_limit: 16384,
    federating: true,
    registrations_open: false,
    invites_enabled: true,
    dedupe_media: true,
    show_instance_panel: true,
    federation_reachability_timeout_days: 7,
    allow_relay: true,
    subject_line_behavior: "masto",
    max_pinned_statuses: 16,
    rewrite_policy: Pleroma.Web.ActivityPub.MRF.SimplePolicy,
    account_activation_required: false,
    finmoji_enabled: true,
    autofollowed_nicknames: ["admin"],
    healthcheck: true

config :pleroma, :fe, false
config :pleroma, :frontend_configurations,
    pleroma_fe: %{
        theme: "radio",
        background: "/static/background.png",
        logo: "/static/logo.png",
        logoMask: false,
        logoMargin: ".1em",
        redirectRootNoLogin: "/main/public",
        redirectRootLogin: "/main/friends",
        chatDisabled: true,
        showInstanceSpecificPanel: true,
        scopeOptionsEnabled: true,
        formattingOptionsEnabled: true,
        collapseMessageWithSubject: true,
        scopeCopy: true,
        subjectLineBehavior: "masto",
        postContentType: "text/plain",
        alwaysShowSubjectInput: true,
        hidePostStats: false,
        hideUserStats: false,
        loginMethod: "password",
        webPushNotifications: false,
        noAttachmentLinks: false,
        nsfwCensorImage: "",
        showFeaturesPanel: true
    }, masto_fe: %{
        showInstanceSpecificPanel: true
    }

import_config "MRF.exs"
import_config "secret.exs"
