"""Logging format context operations."""

from logging import Logger, Formatter
from copy import copy


class LoggingFormatContext:
    """
    Context manager for a different logging format.

    Use in a 'with' statement to temporarily use a different logging
    format for currently active handlers.

    Parameters
    ----------
    logger : logging.Logger
        The default logger instance that will temporarily be modified.
    new_formatter: logging.Formatter
        Logging Formatter instance that will be applied to the handlers
        in the logger.
    """

    def __init__(self, logger: Logger, new_formatter: Formatter):
        self.logger = logger
        self.new_formatter = new_formatter
        self.old_handlers = [copy(h) for h in logger.handlers]

    def __enter__(self):
        """Set new formatter for current logging handlers."""
        for handler in self.logger.handlers:
            handler.setFormatter(self.new_formatter)

    def __exit__(self, exc_type, exc_val, exc_tb):
        """Restore original logging handlers."""
        self.logger.handlers = self.old_handlers
