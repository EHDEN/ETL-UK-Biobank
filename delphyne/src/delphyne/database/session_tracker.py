"""Storage module for tracked sessions."""

from typing import Dict

from ..model.etl_stats import EtlTransformation


class SessionTracker:
    """
    Storage for tracked SQLAlchemy sessions.

    Sessions marked for tracking by their id value, will be stored in
    here. Session event functions from the events module will check if a
    session is stored in here, and if so, will capture table change
    information.

    Attributes
    ----------
    sessions : dict
        Session id to session mapping.
    """

    sessions: Dict[int, EtlTransformation] = {}

    @staticmethod
    def remove_session(session_id) -> None:
        """
        Remove item from sessions, so it will no longer be tracked.

        Parameters
        ----------
        session_id : int
            Id value of the session via `id` builtin.

        Returns
        -------
        None
        """
        if session_id in SessionTracker.sessions:
            del SessionTracker.sessions[session_id]
