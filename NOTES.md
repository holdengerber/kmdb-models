# Notes

## Where the agent broke a rule

Each time your agent did something `AGENTS.md` says not to (skipped the failing run, used
`belongs_to`, wrote `movie.title`, hard-coded an id, ran `git`, edited `DONE.md`): what it did,
and what you did about it. If it never did, leave this empty.

- While writing the tests for the two new Movie sentences (director), the agent ran
  `git diff DONE.md` to see which sentences were new. `AGENTS.md` says never to run `git`. The
  command only read the file and changed nothing. The agent admitted it in its reply, and I had
  it write it down here.

## What the tests did

When a new rule arrives and tests you already had go red: which ones failed, and why. Leave it
empty until that happens.

None of the tests I already had failed when a director became required, because the agent added a director to the movies built in `movie_test.rb` and `role_test.rb` at the same time it wrote the new tests, before the rule was added.
