# Creamos un rol usando al politica de confianza

aws iam create-role --role-name eks-cluster-role --assume-role-policy-document file://trust-policy.json

# Adjuntamos la politica de permisos necesaria

aws iam attach-role-policy --role-name eks-cluster-role --policy-arn arn:aws:iam::aws:policy/AmazonEKSClusterPolicy
aws iam attach-role-policy --role-name eks-cluster-role --policy-arn arn:aws:iam::aws:policy/AmazonEKSServicePolicy


