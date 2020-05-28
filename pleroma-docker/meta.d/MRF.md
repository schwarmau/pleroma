## Instance Blocks/Filters

### Instances we block/filter

**Take a look at our [config file](/hosted/pleroma/src/branch/master/custom.d/config/MRF.exs) (commented and easily readable), or request a fancy listing at [fediverse.network](https://fediverse.network/cyborg.cafe/federation).**

The federation policy of cyborg.cafe is very open.
Even in cases where your instance directly violates our rules,
we will try to solve the problem using MRF filters before resorting to defederation.

TL;DR: Don't federate illegal stuff to us and we're good.

Full policy:

- If your instance leaks our private data, we will `quarantine` it
- If your instance often federates unflagged NSFW, we will flag all your media with `media_nsfw`
    - This also applies if your instance does not have a rule that enforces flagging, or lax rules like "use your best judgement"
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
Send your complaint (with proof) to `gilgamoosh32@gmail.com` or (if we're not blocked *yet*) DM `@gilgamoosh@cyborg.cafe` or `@admin@cyborg.cafe`.

### Blocklists we're on

None so far (that we know of).
