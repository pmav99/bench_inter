import sys

import pandas as pd

import jeodpp.inter
import timer


def get_query_params():
    df = pd.read_csv("query_params.csv")
    return df


def create_tile(x, y, z, proc_id):
    # XXX Returns bytes!
    imgProc = jeodpp.inter.ImageProcess()
    imgProc.readFromDB(proc_id)
    buff = bytearray(512 * 512 * 4)
    imgProc.setMemoryBuffer(buff)
    nbytes = imgProc.createTilePNG(x, y, z)
    buff2 = buff[0:nbytes]
    return buff2


def create_tile_from_row(row):
    msg = "index={index:5d}, x={x:5d}; y={y:5d}; z={z:2d}; procid={proc_id}"
    index, x, y, z, proc_id = row.name, row.x, row.y, row.z, row.proc_id
    with timer.Timer(msg.format(index=index, x=x, y=y, z=z, proc_id=proc_id)):
        png = create_tile(x, y, z, proc_id)
    with open("/tmp/%s.png" % index, "wb") as fd:
        fd.write(png)
    assert len(png) > 400, len(png)
    return png


def main():
    if len(sys.argv) <= 1:
        sys.exit("Usage: python run_single_py INDEX [INDEX [INDEX [...]]]]")

    df = get_query_params()

    msg = "x={x}; y={y}; z={z}; procid={proc_id}"
    indexes = [int(index) for index in sys.argv[1:]]
    for index in indexes:
        row = df.iloc[index]
        result = create_tile_from_row(row)


if __name__ == "__main__":
    main()
