# Creating custom DSN exporters in KiCad 8

While KiCad 8's built-in DSN export (`File > Export > Specctra DSN`)  works well, if you need a custom DSN format or want to automate the  process, you can create your own DSN exporter using Python scripting  with the `pcbnew` module. 

1. Understand the KiCad board structure

To export a custom DSN, you need to understand how KiCad represents board data through the `pcbnew` API. This includes accessing:

- **Components (Footprints):** You can iterate through all footprints on the board to get their  properties, such as reference designators, positions, layers, and pad  details.
- **Nets and Pins:** The API lets you access the nets, their names, and the pins connected to each net.
- **Tracks (Traces):** You can retrieve information about tracks, their layers, widths, and segments.
- **Vias:** Access information about vias, including their positions and sizes.
- **Board Outline (Edge Cuts):** Get the coordinates of the board outline for inclusion in the DSN. 

2. Define your DSN format

Determine the specific DSN format you need. This involves understanding the  syntax and structure required by your target application (e.g., an  external autorouter). If you're working with an existing autorouter,  it's best to consult its documentation for the expected DSN format. 

3. Python script structure

Here's a general outline for a Python script that exports a custom DSN file: 

```python
import pcbnew
import os

def export_custom_dsn(board_file, output_dsn_file):
    # Load the board
    board = pcbnew.LoadBoard(board_file)

    if not board:
        print(f"Error: Could not load board from {board_file}")
        return

    with open(output_dsn_file, 'w') as f:
        # Write DSN header (customize as needed)
        f.write("## Custom DSN Export from KiCad 8\n")
        f.write(f"## Board: {os.path.basename(board_file)}\n")
        f.write("\n")

        # Export Components (Footprints)
        f.write("# Components\n")
        for footprint in board.GetFootprints():
            ref = footprint.GetReference()
            pos = footprint.GetPosition()
            rot = footprint.GetOrientationDegrees()
            layer = board.GetLayerName(footprint.GetLayer())
            # Customize the output format based on your DSN specification
            f.write(f"COMPONENT {ref} {pos.x} {pos.y} {rot} {layer}\n")

        f.write("\n")

        # Export Nets
        f.write("# Nets\n")
        for net in board.GetNets().values():
            net_name = net.GetName()
            f.write(f"NET {net_name}\n")
            # Iterate through pins connected to the net
            for footprint in board.GetFootprints():
                for pad in footprint.Pads():
                    if pad.GetNet().GetNetCode() == net.GetNetCode():
                        f.write(f"  PIN {footprint.GetReference()} {pad.GetName()}\n")

        f.write("\n")
        
        # Export Tracks and Vias (example - you'll need to define the DSN format)
        f.write("# Tracks and Vias\n")
        for track in board.GetTracks():
            # Get track properties and write to DSN
            pass # Replace with your DSN track export logic

        for via in board.GetVias():
            # Get via properties and write to DSN
            pass # Replace with your DSN via export logic

        # Export Board Outline (example - you'll need to define the DSN format)
        f.write("# Board Outline\n")
        # Get board outline segments and write to DSN
        # Example: for segment in board.GetBoardOutline(): ...
        pass # Replace with your DSN board outline export logic


    print(f"Custom DSN exported to {output_dsn_file}")

# Example usage (run this from within KiCad's scripting console or as a standalone script)
if __name__ == "__main__":
    current_board = pcbnew.GetBoard() # Only works if run from within KiCad
    if current_board:
        # Get the path of the current board file
        board_filepath = current_board.GetFileName() 
        if board_filepath:
            # Generate output DSN filename based on the board filename
            base_filename = os.path.splitext(os.path.basename(board_filepath))[0]
            output_dsn_filename = f"{base_filename}_custom.dsn"
            
            export_custom_dsn(board_filepath, output_dsn_filename)
        else:
            print("Current board has no associated file path. Save the board first.")
    else:
        # If running as a standalone script, provide the board file path manually
        print("No board loaded. Provide a board file path if running as a standalone script.")
        # Example: export_custom_dsn("path/to/your/board.kicad_pcb", "output.dsn")
```

4. Running the script

You can run this script in several ways:

- **From the KiCad PCB Editor's Scripting Console:**
  - Open your board in the PCB editor.
  - Go to **Tools > Scripting Console**.
  - Load your script (e.g., `exec(open('your_exporter.py').read())`). [The mbedded.ninja blog suggests](https://blog.mbedded.ninja/electronics/general/kicad/how-to-write-python-scripts-for-kicad/) that this avoids a potentially complex setup of the `pcbnew` libraries in a Python environment.
- **As a standalone Python script:**
  - You'll need to ensure your Python environment is correctly configured to import `pcbnew`. This typically involves setting up the KiCad Python environment or  launching the script using the KiCad Python executable, as suggested on  the [KiCad.info Forums](https://forum.kicad.info/t/getting-started-using-python-scripts/14765).
  - Call the `export_custom_dsn()` function with the paths to your board file and the desired output DSN file. 

5. Automation and integration

- **KiCad CLI:** For full automation without the GUI, consider using `kicad-cli` to export the standard DSN, and then write a separate Python script to parse that DSN and convert it to your custom format.
- **Plugin Integration:** You can integrate your custom exporter into a KiCad plugin, making it accessible directly from the PCB editor's menu. 



Remember to consult the KiCad 8 API documentation and relevant file format  specifications to ensure you're accurately extracting and formatting the data for your custom DSN file.