FROM python:3.14-slim

WORKDIR /app

COPY swob_to_json/ swob_to_json/
COPY test_files/ test_files/
COPY setup.py pyproject.toml README.md ./

RUN python -m pip install --no-cache-dir "pip @ https://files.pythonhosted.org/packages/3f/06/3e4420302363fbb71be3c7f35ce042f54bfca330e3e66b3a2e3c4cca579f/pip-26.2.2-py3-none-any.whl#sha256=fd7f4dfa8190e014013b9f08f3e973f4e4c26ffd179a204895533a7254813a70"
RUN pip install --no-cache-dir .

RUN mkdir -p /output_json

CMD for i in /app/test_files/input_xml/*.xml; do \
    echo "Input: $i"; \
    python -m swob_to_json "$i" > "/output_json/$(basename $i).json"; \
    echo "Output: /output_json/$(basename $i).json"; \
    echo; \
done
