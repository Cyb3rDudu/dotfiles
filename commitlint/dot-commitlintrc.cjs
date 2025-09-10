// Global Commitlint config (symlinked to ~/.commitlintrc.cjs)
// - Extends conventional commits
// - Enforces flat scopes (no '/') and allowed characters

module.exports = {
  extends: ['@commitlint/config-conventional'],
  plugins: [
    {
      rules: {
        'scope-flat': (parsed /*, when = 'always', value */) => {
          const s = parsed && parsed.scope;
          if (!s) return [true];
          if (typeof s !== 'string') return [true];
          if (s.includes('/')) {
            return [false, "scope must be flat (no '/') — e.g., use 'api' instead of 'backend/api'"];
          }
          if (!/^[A-Za-z0-9_.-]+$/.test(s)) {
            return [false, "scope contains invalid characters (allowed: A–Z a–z 0–9 _ . -)"];
          }
          return [true];
        }
      }
    }
  ],
  rules: {
    // Keep scopes optional; enforce flat/allowed chars when present
    'scope-empty': [0, 'never'],
    'scope-flat': [2, 'always']
  }
};

