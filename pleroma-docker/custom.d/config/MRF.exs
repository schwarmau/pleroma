use Mix.Config

defmodule CofeMRF do

    #
    # Instances where all media attachments will be
    # preemptively marked as NSFW
    #
    def media_nsfw(), do: []

    #
    # Instances where all media attachments
    # are removed from incoming messages
    #
    def media_removal(), do: []

    #
    # A combination of `media_nsfw` and `nonpublic`.
    #
    def critical(), do: []

    #
    # Instances where a lot of public noise happens,
    # or where most of the public text content is offensive or NSFL
    #
    def nonpublic(), do: []

    #
    # Instances that don't get our private/follow-only posts.
    #
    def quarantine(), do: []

    #
    # Instances which are completely blocked
    #
    def reject(), do: []

end

config :pleroma, :instance,
    quarantined_instances: CofeMRF.quarantine()

config :pleroma, :mrf_simple,
    media_removal: CofeMRF.media_removal(),
    media_nsfw: CofeMRF.media_nsfw() ++ CofeMRF.critical(),
    reject: CofeMRF.reject(),
    federated_timeline_removal: CofeMRF.nonpublic() ++ CofeMRF.critical()
