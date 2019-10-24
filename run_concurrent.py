import sys


from concurrent.futures import ProcessPoolExecutor, as_completed
import pandas as pd

import jeodpp.inter
import timer
from run_serial import *



def main():
    if len(sys.argv) != 3:
        sys.exit("Usage: python run_single_py NO_PROCESSES NO_FILES")

    no_processes = int(sys.argv[1])
    no_files = int(sys.argv[2])

    df = get_query_params()

    with ProcessPoolExecutor(no_processes) as executor:
        future_processes = [executor.submit(create_tile_from_row, df.loc[index]) for index in df.sample(no_files).index]

    results = [f.result() for f in as_completed(future_processes)]
    for result in results:
        pass


if __name__ == "__main__":
    main()
