# Crear un rol ec2-admin en una instancia EC2
# Crear el rol usando la política de confianza
aws iam create-role --role-name ec2-admin --assume-role-policy-document file://trust-policy.json

# Adjuntar la política de permisos
aws iam attach-role-policy --role-name ec2-admin --policy-arn arn:aws:iam::aws:policy/AdministratorAccess

# Crear una instancia de perfil y asociarla al rol
aws iam create-instance-profile --instance-profile-name ec2-admin-profile

# Agregar el rol al perfil de la instancia
aws iam add-role-to-instance-profile --instance-profile-name ec2-admin-profile --role-name ec2-admin

# Asociar el perfil de la instancia a la instancia EC2
INSTANCE_ID="i-0f7bf26adf3e529ea"
aws ec2 associate-iam-instance-profile --instance-id $INSTANCE_ID --iam-instance-profile Name=ec2-admin-profile
