# Presentation companion: Architecting Reproducible Science

This companion follows the current 14-slide presentation in `slides/`. It gives
reviewers the argument and the intended transitions without changing or
duplicating the presentation itself.

## Slide 1: Architecting reproducible science

Introduce the session as software-engineering practices that improve HPC work.
The theme is not abandoning notebooks; it is making successful notebook work
reliable enough to share, test, automate, and run elsewhere.

## Slide 2: Who is Fernando Garzon

Briefly establish the presenter as an SDSC computational/data-science research
specialist who supports TSCC users and works on software-development projects.
Use this only as context for the practical emphasis on automation and deployment.

## Slide 3: Outline

The sequence is Milena's reproducibility failure, notebooks versus modular
packages, production-oriented code structure, GitHub Actions, MLOps, and final
remarks. The subsequent tutorial applies the package/testing part with skydiver.

## Slide 4: The unreproducibility horror

Use Milena's video to distinguish a correct model from a fragile workflow. Her
notebook fails during a stakeholder demo because one apparently minor cell was
not executed. The lesson is that hidden execution state can destroy trust in an
otherwise good result.

## Slide 5: Notebooks do not scale as well as packages

Define the three working meanings of reproducibility used in the talk:

- **Repeatable:** the workflow gives consistent results.
- **Portable:** it can run beyond the author's laptop, including on Expanse.
- **Scalable:** it can be operated at a larger resource or user scale while
  maintaining acceptable performance and reliability.

These are related but not identical claims. A single successful notebook run is
not evidence of all three.

## Slide 6: Exploration versus maintainability

Respect notebooks as fast tools for exploratory work, while naming their
maintenance risk: cells can become an uncontrolled code base when reusable logic
is spread across hidden state and ad hoc execution order. The alternative is a
modular Python package whose reusable behavior is easier to test and deploy.

## Slide 7: Let us productionize the code

Connect the larger MNIST example to the smaller skydiver exercise. A modular
package is not magic; it needs clear code, tests, documented dependencies, and a
versioned release. The practical strategy is to migrate the reusable notebook
logic into a package boundary.

## Slide 8: AI-assisted refactoring still needs engineering rules

Prompt engineering can help restructure code, but the desired output remains
concrete: focused functions, cohesive modules, private helpers where useful, no
global execution at import time, type hints, documentation, and a `main()` entry
point. The human author remains responsible for reviewing both scientific and
software correctness.

## Slide 9: Lights, camera, GitHub Actions

Define DevOps as disciplined automation of testing and deployment. GitHub
Actions is an accessible first automation step for a student repository. It
helps establish the habit that a repository should demonstrate its own health.

## Slide 10: What CI should automate first

Start with unit tests and code coverage, then extend as the project needs it:
linting, security checks, integration/smoke tests, and release checks. In the
tutorial, Actions runs nbdev export, confirms generated code is committed, runs
tests, and builds the package.

## Slide 11: MLOps

MLOps combines ML practice with DevOps discipline: testing, release, and
operation of model-related software. Its purpose is not a label; it is keeping a
model's quality and deployment path observable and repeatable.

## Slide 12: Deployment scale

The large deployment counts are a motivation for automation. Do not imply that a
student project needs enterprise deployment volume. The useful takeaway is that
repeatable release processes are valuable well before an organization reaches
that scale.

## Slide 13: Final remarks

Return to the central distinction: modeling skill matters, and deployment skill
makes valuable work usable by others. Tests come before expensive model runs;
GitHub Actions is a first step toward broader CI/CD, DevOps, and MLOps practice.

## Slide 14: Questions and tutorial handoff

Use the Q&A, then direct students to the tutorial. They create a new repository,
copy the skydiver seed project, protect local credentials, test and build a
package, and follow the PyPI-to-Expanse guide with the facilitator.
