# https://github.com/returntocorp/semgrep/issues/2783
def test():
    a = "FOO"
    a = a.lower()
    # using symbolic propagation we know that `a` is `"FOO".lower()`
    if a != "BAR".lower():
        pass
