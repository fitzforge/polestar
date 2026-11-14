---
section: contributors
---
- The pre-push hook (`tools/hooks/pre-push`) checks only the commits that
  aren't on `origin` yet, so a push after a rebase or a merge of the base
  branch no longer stops on commits that were already public.
