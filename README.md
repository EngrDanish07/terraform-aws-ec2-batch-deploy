# Terraform AWS: Multiple EC2 Instances with Nginx

This project uses Terraform to launch **three EC2 instances** on AWS. Each with **different instance types** (`t3.micro`, `t3.small`, etc.) and all set up with Nginx using a common user data script.

It’s mainly a hands-on attempt to understand and apply **Terraform meta-arguments**, especially `for_each` and `depends_on`.

---

### Why This Project?

I wanted to go beyond launching a single instance and explore how you can scale things while keeping the code clean and reusable.

By using:
- `for_each` to loop through a map of EC2 configs
- `depends_on` to manage resource creation order

…I was able to provision multiple servers **with different configurations** using just a few lines of reusable code.

### What It Does

- Uses the default AWS VPC
- Creates a security group (SSH, HTTP, HTTPS)
- Launches 3 EC2 instances with different types (t3.micro, t3.small)
- Installs Nginx on each instance using a shared shell script
- Reuses a single key pair for SSH access
- Outputs public and private IPs + DNS for each instance

### File Structure

<pre>
.
├── main.tf              # Main Terraform config (resources)
├── variables.tf         # EC2 config map with different types
├── outputs.tf           # Public/private IPs and DNS outputs
├── providers.tf         # AWS provider block
├── terraform.tf         # Required providers version
├── simple_web.sh        # User data script to install Nginx
├── .gitignore           # Ignore state, lockfiles, and keys
└── README.md
</pre>

### Notes

- The EC2 configurations are defined in variables.tf
- All instances run the same user data script, but that can be easily changed per instance
- This is just for learning and testing, not production
- The security group allows open SSH (0.0.0.0/0), which is unsafe for public use — don’t do this in production
