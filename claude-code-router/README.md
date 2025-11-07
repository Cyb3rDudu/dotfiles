# Claude Code Router

Configuration for [claude-code-router](https://github.com/thomasgauthier/claude-code-router), a tool that enables dynamic model routing in Claude Code based on context and task type.

## Features

- **Automatic Model Routing**: Routes requests to optimal models based on:
  - Context length (switches to long-context models when needed)
  - Task type (thinking, web search, image analysis)
  - Background vs. foreground tasks
- **Multi-Provider Support**: Integrates with OpenRouter, DeepSeek, and Ollama
- **Model Selection**: Provides access to latest models like Gemini 2.5, Kimi K2, DeepSeek Reasoner

## Setup

1. **Copy Template to Config**:
   ```bash
   cd ~/.claude-code-router
   cp config.json.template config.json
   ```

2. **Add API Keys**:
   Edit `config.json` and replace placeholders:
   - `REPLACE_WITH_YOUR_OPENROUTER_API_KEY` - Get from [OpenRouter](https://openrouter.ai/keys)
   - `REPLACE_WITH_YOUR_DEEPSEEK_API_KEY` - Get from [DeepSeek](https://platform.deepseek.com/api_keys)

3. **Install and Start Router**:
   ```bash
   # Install (if not already installed)
   npm install -g claude-code-router

   # Start the router
   claude-code-router
   ```

## Router Configuration

The router automatically selects models based on:

- **Default**: Claude Sonnet 4 (via OpenRouter)
- **Background Tasks**: Claude Sonnet 4
- **Thinking/Reasoning**: DeepSeek Chat
- **Long Context** (>60K tokens): Gemini 2.5 Pro
- **Web Search**: Gemini 2.5 Flash
- **Image Analysis**: Gemini 2.5 Pro

## Available Models

### OpenRouter
- `google/gemini-2.5-pro` - Long context, multimodal
- `google/gemini-2.5-flash` - Fast inference
- `moonshotai/kimi-k2` - Long context specialist
- `anthropic/claude-sonnet-4` - Latest Claude
- `anthropic/claude-3.5-sonnet`
- `anthropic/claude-3.7-sonnet:thinking` - Extended reasoning

### DeepSeek
- `deepseek-chat` - General purpose with tool use
- `deepseek-reasoner` - Advanced reasoning mode

### Ollama (Local)
- `qwen2.5-coder:latest` - Code-optimized model

## Files

- `config.json.template` - Template with placeholders (tracked in git)
- `config.json` - Your config with actual API keys (gitignored)
- `plugins/` - Custom router plugins (if any)
- `logs/` - Runtime logs (gitignored)
- `.claude-code-router.pid` - Process ID file (gitignored)

## Integration with Other Tools

This router configuration complements:
- **Claude Code** - Main interface using the router
- **OpenCode** - Alternative AI coding tool with own model config
- **Codex** - Another AI coding interface

All tools share credential storage via shell environment variables (99-secrets files).

## Troubleshooting

**Router not connecting:**
- Check that router is running: `ps aux | grep claude-code-router`
- Verify port 3456 is available: `lsof -i :3456`
- Check logs in `~/.claude-code-router/logs/`

**Model not available:**
- Verify API keys are valid
- Check OpenRouter/DeepSeek account has credits
- Review model availability at provider websites

**Context too long for default model:**
- Router should automatically switch to Gemini 2.5 Pro at >60K tokens
- Adjust `longContextThreshold` in config if needed

## Reference

- [claude-code-router GitHub](https://github.com/thomasgauthier/claude-code-router)
- [OpenRouter Documentation](https://openrouter.ai/docs)
- [DeepSeek API Docs](https://api-docs.deepseek.com/)
