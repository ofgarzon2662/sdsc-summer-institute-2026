# Architecting Reproducible Science

These notes accompany the presentation and preserve the argument behind the
visual slides. They are not a word-for-word script. The PowerPoint contains
more detailed presenter notes, including the full Milena video transcript and
live-demo cues.

## Session shape

- 60 minutes: presentation and short demonstrations
- 10 minutes: audience questions
- 20 minutes: self-paced tutorial with a facilitator

The tutorial begins after the Q&A. It is designed to be read by attendees while
another instructor helps the room.

## 1. The reproducibility horror

Milena has a strong model in a Jupyter notebook. During a high-stakes
demonstration she runs cells out of order, misses the optimization routine that
controls memory use, and freezes the notebook. Her mathematics did not suddenly
become wrong. The workflow depended on hidden state and an execution history
that existed only in her head.

The story introduces the session's central question:

> Can another person produce the same result, from a clean environment, without
> reconstructing the author's memory?

## 2. Notebooks and packages

Notebooks are excellent laboratories. They make exploration, visualization, and
iteration fast. Their weakness is not that they are notebooks; it is that
important behavior can remain implicit:

- cells can run in a different order than they appear;
- imports, paths, and data may exist only on one machine;
- long-running work can happen during import;
- scientific assumptions may be written in prose but never checked;
- collaborators may not know which cells form the reusable model.

A package makes the reusable contract explicit. Inputs become function
arguments, reusable code gains stable import paths, heavy execution moves behind
an entry point, and dependencies become installable metadata.

## 3. Notebook to package

The live example uses nbdev to keep the notebook useful while exporting selected
cells into a Python module. The workflow is intentionally small:

```bash
python -m venv .venv
python -m pip install -e ".[dev]"
nbdev-export
pytest
skydiver --mass 80 --drag 0.26
```

The skydiver example turns a one-dimensional drag equation into a package and a
command-line interface. The important move is not the particular tool. It is
separating exploration from the public, testable behavior other programs can
call.

This material uses nbdev 3 syntax and `pyproject.toml` configuration. Older
nbdev projects may need `nbdev-migrate-config` before using the current
commands.

## 4. Tests and GitHub Actions

Tests should protect scientific meaning, not merely execute lines of code. The
tutorial checks that:

- invalid physical parameters are rejected;
- terminal velocity is positive and matches a known calculation;
- increasing mass increases terminal velocity;
- increasing drag lowers terminal velocity;
- the time to approach terminal velocity is finite and positive.

GitHub Actions then runs those tests from a clean checkout. This turns a local
claim into a repeatable project rule: changes must reinstall successfully and
preserve the scientific contract before a wheel or container is released.

## 5. One artifact, many deployments

The package is built once and carried forward:

1. Export the reusable code.
2. Test the contract.
3. Build a wheel.
4. Install the wheel in a container.
5. Run the same entry point locally, in CI, or under a scheduler.

A container improves portability by recording the runtime environment. It does
not prove the model is correct, and it does not make a workflow scalable by
itself. Tests, versioned inputs, resource requests, and measured performance are
still required.

On SDSC systems, the scheduler owns compute resources. Submit work with an
appropriate allocation, partition, QOS, time limit, memory request, and GPU
request. Use `singularity exec --nv` only when the application actually needs
an allocated NVIDIA GPU. The examples in [`resources`](resources) are templates;
account names and available modules must be checked on the target system.

## 6. Takeaways

The model did not need to change. The workflow did.

- Make execution order explicit.
- Turn assumptions into tests.
- Keep data paths and expensive work out of module import.
- Record dependencies and build installable artifacts.
- Build once, then run the same entry point everywhere.
- Treat notebooks as valuable interfaces to exploration, not as the only record
  of the software system.

Continue with the [20-minute tutorial](tutorial/README.md). The complete
[`mnist_ae`](mnist_ae) snapshot is available as a larger reference implementation
after the session.
