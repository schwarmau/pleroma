use Mix.Config

# ################################################################################
#
# >> Please **don't** use this as a general-purpose "blocklist". <<
#
# I created this file to protect myself and my instance from
# unexpected NSFW surprises, and to prevent spam.
#
# If you ended up here it (usually) **doesn't** mean that you're
# a bad instance full of bad people who should be ashamed of themselves.
# You're free to file a dispute at any time, unless you're in our `reject` policy.
#
# Send me a mail (sn0w@sn0w.sh) or hit me up on fedi (@sn0w@cofe.rocks).
# We'll figure something out.
#
# ################################################################################

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
    # This is, for example, for porn sites and the likes.
    #
    # Removing their media is a great start, but you likely don't
    # want "#sexy #blonde #bodyrub" on your frontpage either.
    #
    def critical(), do: []

    #
    # Instances where a lot of public noise happens,
    # or where most of the public text content is offensive or NSFW
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
