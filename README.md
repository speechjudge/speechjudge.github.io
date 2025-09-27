## Template for Demo Page

This is a template for creating a demo page.

### Note

Run the following command to set your GitHub user name and email before committing changes.

**This helps to ensure double blind reviews.**

1. Find private email: https://github.com/settings/emails
2. Generate password: https://github.com/settings/personal-access-tokens/new

```bash
git clone https://speechjudge:PASSWORD@github.com/speechjudge/speechjudge.github.io.git ; cd speechjudge.github.io
git config user.name speechjudge ; git config user.email 234011753+speechjudge@users.noreply.github.com
```


## Demo Page Structure

- SpeechJudge-Data + SpeechJudge-Eval
  - data pairs & human annotation.
    - i.e. (t, a_1, a_2, y_H), where t is target text, a_1 and a_2 are two audio samples (Audio A and Audio B), and y_H is human preference (A or B).
  - eval prompts used in AudioLM (open-source and closed-source).
    - plain
    - cot
    - zero-shot (if applicable)
- SpeechJudge-GRM
  - Interpretability.
  - Random @5 results.
- Application
  - Post-training on Qwen2.5-0.5B-TTS Comparison
    - base
    - speechjudge-data
    - speechjudge-grm (offline)
    - speechjudge-grm (online)
  - Best-of-N selection for Qwen2.5-Omni (Talker)

For simplicity, select 5 cases as example to explain in all sections.
- regular + en
- regular + zh
- expressive + en
- expressive + zh
- expressive + mixed (code-switching)


## Revised by GPT:

# SpeechJudge: Towards Human-level Judgement for Speech Naturalness

## **1. Overview**

### Goal  
Briefly describe **SpeechJudge**: a large-scale dataset and generative reward model (GRM) for evaluating speech naturalness.

### Key Contributions  
- **SpeechJudge-Data & Eval**: 99K human-annotated speech pairs across English, Chinese, and code-switching.  
- **SpeechJudge-GRM**: A generative reward model with interpretability and high agreement with human judgments.  
- **Applications**: TTS post-training and high-quality sample selection.

---

## **2. Data Pipeline**

*(Based on Fig. 8, p.18)*

### Dataset Refinement Stages  
| Subset | Size | Filtering Criteria |
|--------|------|--------------------|
| Raw pairs | 99K | All human annotations |
| Preference pairs (pref) | 79K | Remove “Tie” labels |
| High-quality (hq) | 44K | WER gap < 12% |
| Train/Dev | 42K / 1K | Split for GRM training |
| Eval | 1K | Full Agreement human labels |

**Visual:** Flowchart or simple diagram showing filtering steps.

---

## **3. Human Annotation**

*(Sec. 3.2, Fig. 9 p.21)*

- **Process:** Two tasks: (1) pronunciation error detection, (2) naturalness comparison on a 5-level CMOS scale collapsed to ternary preference.  
- **Annotators:** 69 professional raters; average 2.49 annotations per pair.  
- **Agreement Levels:** Full, Weak, None. Majority have ≥60% agreement.  
- **Guideline Criteria:** clarity, prosody, rhythm, stress.

**Visual/Interactive:**  
- Pie chart of agreement levels.  
- Excerpt from annotation guideline.

---

## **4. Benchmark Evaluation**

*(Table 2, p.6)*

### Evaluation Protocol  
- **Prompts:**  
  - *Plain* – direct naturalness rating.  
  - *Chain-of-Thought (CoT)* – rating + reasoning.  
  - Zero-shot (if applicable).  
- **Models tested:** open-source and closed-source AudioLLMs (e.g., Gemini-2.5-Flash, GPT-4o Audio).

### Results  
- Even the best AudioLLM (Gemini-2.5-Flash) achieves **<70% agreement** with human judgments.  
- Traditional MOS predictors and deepfake detectors perform worse.

**Visual:** Table or bar chart comparing accuracy of different models.

---

## **5. SpeechJudge-GRM**

### Model Training & Method  
*(Fig. 4 p.7)*  
- **Stage 1:** Gemini-2.5-Flash generates CoT rationales for challenging pairs.  
- **Stage 2:** GRPO-based Reinforcement Learning on these challenging cases.  
- **Inference-time Scaling:** Majority voting (@10) improves accuracy from 77.2% → 79.4%.

### Interpretability  
- CoT outputs explain each preference decision.

**Visual:**  
- Diagram of SFT + RL pipeline.  
- Example GRM CoT rationale.

---

## **6. Random @5 Demo Cases**

Provide 5 representative cases:

| Type | Languages |
|------|----------|
| Regular + English |
| Regular + Chinese |
| Expressive + English |
| Expressive + Chinese |
| Expressive + Code-switching |

For each case:  
- Target text.  
- Two audio samples (playable).  
- Human preference label.  
- GRM prediction and CoT rationale.

---

## **7. Applications**

### A. Post-training on Qwen2.5-0.5B-TTS  
*(Fig. 6 p.8; Table 6 p.23)*  
Compare base model vs. four alignment settings:  
- base  
- +SpeechJudge-Data  
- +SpeechJudge-GRM (offline)  
- +SpeechJudge-GRM (online)  

**Metrics:** T-ACC, Naturalness CMOS, WER, speaker similarity win/tie/lose.

### B. Best-of-N Selection for Qwen2.5-Omni (Talker)  
*(Fig. 5 p.8)*  
- Best-of-100 sample selection.  
- GRM outperforms BTRM in human win/tie/lose outcomes.

**Visuals:**  
- Bar charts of T-ACC, CMOS improvements.  
- Win/Tie/Lose comparison for Best-of-N.

---

## **8. Ethics and Reproducibility**

*(p.10)*  
- Paid annotators under fair conditions.  
- Data sourced from licensed corpora.  
- Potential dual-use risks (e.g., deepfakes) acknowledged.  
- **Open release:** data, benchmark, GRM model and code to be made public.

---

## **9. Resources & Citation**

- Link to dataset & code repository (when public).  
- BibTeX citation for the paper.

---

### ✅ Tips for Implementation

- **Interactive audio players** for all example pairs.  
- **Collapsible sections** for CoT rationales to avoid clutter.  
- **Download links** for evaluation prompts and subset statistics.

