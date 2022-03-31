from _typeshed import StrOrBytesPath

__all__ = ["netrc", "NetrcParseError"]

class NetrcParseError(Exception):
    filename: str | None
    lineno: int | None
    msg: str
    def __init__(self, msg: str, filename: StrOrBytesPath | None = ..., lineno: int | None = ...) -> None: ...

# (login, account, password) tuple
_NetrcTuple = tuple[str, str | None, str | None]

class netrc:
    hosts: dict[str, _NetrcTuple]
    macros: dict[str, list[str]]
    def __init__(self, file: StrOrBytesPath | None = ...) -> None: ...
    def authenticators(self, host: str) -> _NetrcTuple | None: ...
