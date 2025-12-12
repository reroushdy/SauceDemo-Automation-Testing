*** Variables ***
# Wait strategies
${WAIT_SHORT}        2s
${WAIT_MEDIUM}       5s
${WAIT_LONG}         10s

# Retry behavior for flaky elements or transitions
${RETRY_COUNT}       2

# Logging & Visual Evidence
${SCREENSHOT_ON_FAILURE}      True

# Test execution behavior
${ENABLE_DEBUG_LOGS}          False

# Misc settings that might be useful later
${SCROLL_BEHAVIOR}            auto