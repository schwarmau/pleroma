## Instance Blocks/Filters

### Instances we block/filter

**Take a look at our [config file](/hosted/pleroma/src/branch/master/custom.d/config/MRF.exs) (commented and easily readable), or request a fancy listing at [fediverse.network](https://fediverse.network/cofe.rocks/federation).**

The federation policy of cofe.rocks is very open.
Even in cases where your instance directly violates our rules,
we will try to solve the problem using MRF filters before resorting to defederation.

TL;DR: Don't federate illegal stuff to us and we're good.

Full policy:

- If your instance leaks our private data, we will `quarantine` it
- If your instance often federates unflagged NSFW, we will flag all your media with `media_nsfw`
    - This also applies if your instance does not have a rule that enforces flagging, or lax rules like "use your best judgement"
- If a major share of your users are sharing NSFW-art or porn, or if sharing these things is your instance's primary purpose, we apply `critical`
- If your instance allows loli, shota, or other sexualizations of minors, we apply `media_nsfw` or `critical`, depending on the severity
    - In extreme cases (for example an instance with the sole purpose of sharing child porn) we will resort to `media_remove` or `reject` **(!)**
- If your instance spams our servers over extended periods of time, a high ratelimit or `reject` **(!)** will be discussed depending on severity

Legend:

| Level | Explanation |
|:------|:------------|
| `open` | Implicit level. Your instance is in good standing and nothing will happen. |
| `media_nsfw` | All media from your instance will be preemptively marked as NSFW |
| `media_removal` | All media from your instance will be removed |
| `nonpublic` | Your instance's posts will not appear on public timelines |
| `critical` | Combination of `media_nsfw` and `nonpublic` |
| `quarantine` | Your instance will not receive private or follow-only posts |
| `reject` | Complete block |

### Instances that block us

None so far (that we know of).

If you're planning to block us:
Please try to open a dialog before resorting to such extreme measures.
Only very few rules here are set in stone, and no user has some kind of special status.
In 9 out of 10 cases, we can find a solution that doesn't impact both of our userbases this dramatically.
Send your complaint (with proof) to `sn0w@sn0w.sh` or (if we're not blocked *yet*) DM `@sn0w@cofe.rocks` or `@admin@cofe.rocks`.

### Blocklists we're on

None so far (that we know of).

cofe.rock's predecessor cofe.moe has been listed on Dzuk's ["blockchain"](https://github.com/dzuk-mutant/blockchain/blob/master/list/instances/cofe_moe/cofe_moe.md) without reaching out or asking for rule clarification. Our new rule page is a bit more verbose, but the content is basically the same. As such it might be possible that we land on such a list again in the future. This didn't happen so far though.
