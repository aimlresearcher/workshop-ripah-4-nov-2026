# Agentic AI Workshop — Windows 11

Nine short Jupyter notebooks that teach agentic AI step by step, using a **free model running on your own computer**
through Ollama. No API key, no account, no cloud service, and no internet after the model is downloaded.

## Setup (once)
1. Unzip the workshop to a normal folder (for example `Documents`). Do not run it from inside the zip.
2. Double-click **`setup_windows.bat`**.
   It installs Ollama and Python with winget, starts Ollama, downloads `llama3.2` (about 2 GB),
   creates `.venv` and installs the Python packages. Windows may ask you to allow the installers — click **Yes**.
3. If it says `ollama` or `py` was not found right after installing: close the window and double-click `setup_windows.bat` again.

**Every time after that:** double-click **`start_workshop.bat`**.
JupyterLab opens in your browser. Start with `notebooks/00_Setup_and_First_Call.ipynb`. Keep the black window open while you work.

## Installing Ollama by hand (if the setup script fails)
1. **Download** `OllamaSetup.exe` from ollama.com/download → Windows (or in PowerShell: `winget install -e --id Ollama.Ollama`).
2. **Install**: double-click it and click **Install**. It installs into your user account — no administrator needed. Needs Windows 10 22H2 or newer.
3. **Check it runs**: a llama icon appears near the clock. In a *new* PowerShell window `ollama --version` prints a version, and `http://localhost:11434` in a browser says “Ollama is running”.
4. **Get the model**: `ollama pull llama3.2` (about 2 GB, once), then `ollama list`.
5. **Test it**: `ollama run llama3.2 "Say hello"` — type `/bye` to leave.
6. Then double-click `setup_windows.bat` again for Python and the workshop packages.

<details><summary>Or type all the commands yourself (PowerShell)</summary>

```powershell
winget install -e --id Ollama.Ollama
winget install -e --id Python.Python.3.12
# close PowerShell and open it again, then:
ollama pull llama3.2
py -m venv .venv
.venv\Scripts\Activate.ps1
python -m pip install -r requirements.txt
jupyter lab
```
If `Activate.ps1` is blocked, run once: `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned`.
</details>

Ollama needs Windows 10 22H2 or newer; it installs into your user account (no administrator needed).

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
| `Ollama is not running` | Open **Ollama** from the Start menu (or run `ollama serve` in PowerShell) |
| `llama3.2 is missing` | In PowerShell: `ollama pull llama3.2` |
| `ModuleNotFoundError: ollama` | Start with `start_workshop.bat`, or run `setup_windows.bat` again, then restart the kernel |
| `running scripts is disabled` | Use the `.bat` files, or run once: `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned` |
| `winget` is not recognized | Install **App Installer** from the Microsoft Store |
| `ollama` or `py` is not recognized | Close the window and open it again (or restart Windows) |
| Very slow | Use `llama3.2:1b`; a recent NVIDIA or AMD driver lets Ollama use the GPU |
| Strange errors | **Kernel → Restart Kernel and Run All Cells** |

## Folder
```
windows_11\
├── setup_windows.bat    double-click once (runs setup_windows.ps1)
├── start_workshop.bat   double-click every time
├── notebooks\           00–08
├── solutions\           08_Exercises_Solutions.ipynb
├── datasets\            products.csv · invoices.csv · research_documents.json (synthetic teaching data)
├── outputs\             created when you run Notebook 07 (the saved report)
└── requirements.txt
```

Workshop adaptation and delivery: Syed Hamed Raza and Abdul Ahad Syed. Some examples are adapted from publicly available agentic-AI course materials.
