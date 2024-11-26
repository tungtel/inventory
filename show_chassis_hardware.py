from netmiko import ConnectHandler
import pandas as pd

# Output file name
output_file = "router_hardware_info_test.txt"

# Read router credentials from the CSV file
df = pd.read_csv('credential.csv')
print(df)

# Iterate over each router in the DataFrame
for index, row in df.iterrows():
    print(index, row['hostname'], row['ip'], row['username'], row['password'])
    try:
        # Create a dictionary of parameters to connect to the router
        router = {
            'device_type': 'juniper_junos',
            'ip': row['ip'],
            'username': row['username'],
            'password': row['password']
        }
        print(router)

        # Connect to the router
        net_connect = ConnectHandler(**router)

        # Send the command to get the hardware information
        output = net_connect.send_command('show chassis hardware')
        print(output)


        # Write the output to a file
        with open(output_file, 'a') as f:
            f.write(f"Router:router {row['hostname']}: {row['ip']}\n")
            f.write(output)
            f.write("\n")


        # complete and disconnect from the router
        print(f'completed router {row['hostname']}:{row['ip']}')
        print('#'*50)
        net_connect.disconnect()

    except Exception as e:
        print(f"Error connecting to {row['ip']}: {e}")
        continue

print("Done writing hardware information to file.")

