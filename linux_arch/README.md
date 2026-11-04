# Agentic AI Workshop — Arch Linux

Nine short Jupyter notebooks that teach agentic AI step by step, using a **free model running on your own computer**
through Ollama. No API key, no account, no cloud service, and no internet after the model is downloaded.

## Setup (once)
Open a terminal **in this folder** and run:

```bash
./setup_arch.sh
```
It installs Ollama and Python with pacman (asks for your password), starts Ollama, downloads `llama3.2` (about 2 GB),
creates `.venv` and installs the Python packages.

**Every time after that:**

```bash
./start_workshop.sh
```
JupyterLab opens in your browser. Start with `notebooks/00_Setup_and_First_Call.ipynb`.

<details><summary>Or type the commands yourself</summary>

```bash
sudo pacman -S ollama python python-pip
sudo systemctl enable --now ollama
ollama pull llama3.2
python -m venv .venv
source .venv/bin/activate
python -m pip install -r requirements.txt
jupyter lab
```
</details>

GPU: with an NVIDIA or AMD card you can install `ollama-cuda` or `ollama-rocm` instead of `ollama`.

## The notebooks
| # | Notebook | You learn | Model calls* |
|---|---|---|---|
| 00 | Setup and first call | Ollama, `ask()`, tokens, system messages | ~6 |
| 01 | Agentic workflows | One step vs plan → draft → check → improve | ~6 |
| 02 | Reflection | Critique and improve; fix code using real test results | ~4–6 |
| 03 | Tool use | Python functions as tools, the tool loop, safety | ~9–15 |
| 04 | Evaluations | Test sets, accuracy, error analysis, a judge model | ~22 |
| 05 | Planning | Plan → check → run → answer, re-planning | ~2–4 |
| 06 | Multi-agent | Researcher, writer and reviewer working together | ~3–7 |
| 07 | Capstone | A research assistant with real, checked sources | ~4–7 |
| 08 | Exercises | Seven short exercises with automatic checks (solutions in `solutions/`) | 3 |

\*Approximate. On a computer without a GPU each call can take several seconds.

## How every notebook works
- **Run the two setup cells first.** They check that Ollama is ready and create `ask(prompt, system)`.
- Then run the cells **from top to bottom** (Shift + Enter).
- Each notebook ends with *Try it yourself* tasks and a short summary.
- The matching slides are in the `slides/` folder next to this one (same number as the notebook).

## Choosing a model
- Default: `llama3.2` (small, supports tools). Change `MODEL = "..."` in the first setup cell to use another one.
- Slow computer: `ollama pull llama3.2:1b`, then `MODEL = "llama3.2:1b"`.
- Better at tools, plans and JSON (if your computer has enough memory): `ollama pull qwen2.5:7b`, then `MODEL = "qwen2.5:7b"`.
- Notebook 03 needs a model with **tools** in its capabilities: check with `ollama show <model>`.

Small models make mistakes (a wrong tool, a bad plan, invalid JSON). The notebooks check the results with code and say so
clearly instead of crashing; run the cell again or try a bigger model.

## If something goes wrong
| Message | Fix |
|---|---|
| `Ollama is not running` | `sudo systemctl start ollama` |
| `llama3.2 is missing` | `ollama pull llama3.2` |
| `ModuleNotFoundError: ollama` | Start with `./start_workshop.sh`, or run `./setup_arch.sh` again, then restart the kernel |
| `externally-managed-environment` | You ran pip outside `.venv` — use the scripts, or `source .venv/bin/activate` first |
| `Permission denied` on a `.sh` file | `chmod +x setup_arch.sh start_workshop.sh` |
| Very slow | Use `llama3.2:1b`, or a GPU build (`ollama-cuda` / `ollama-rocm`) |
| Strange errors | **Kernel → Restart Kernel and Run All Cells** |

## Folder
```
linux_arch/
├── setup_arch.sh        run once
├── start_workshop.sh    run every time
├── notebooks/           00–08
├── solutions/           08_Exercises_Solutions.ipynb
├── datasets/            products.csv · invoices.csv · research_documents.json (synthetic teaching data)
├── outputs/             created when you run Notebook 07 (the saved report)
└── requirements.txt
```

Workshop adaptation and delivery: Syed Hamed Raza and Abdul Ahad Syed. Some examples are adapted from publicly available agentic-AI course materials.
