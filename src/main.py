#!/usr/bin/env python3

import typer
def main():
    app = typer.Typer(
        name="maat-scripts", help="""Maat scripts.""", no_args_is_help=True
    )
    from merge.merge_comp_freqs import merge_command
    from miner.complexity_analysis import calculate_whitespace_complexity

    app.command(name="merge-comp-freqs", no_args_is_help=True)(merge_command)
    app.command(name="whitespace-complexity", no_args_is_help=True)(calculate_whitespace_complexity)

    app(ignore_unknown_options=True)

if __name__ == "__main__":
    main()
